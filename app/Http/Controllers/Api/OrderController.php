<?php

namespace App\Http\Controllers\Api;

use Exception;
use App\Models\Sale;
use App\Models\Product;
use App\Models\Customer;
use App\Models\Delivery;
use Illuminate\Support\Str;
use App\Models\Product_Sale;
use Illuminate\Http\Request;
use App\Models\OrderTracking;
use App\Models\RewardPointTier;
use App\Models\RewardPointSetting;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;

class OrderController extends Controller
{
    protected function generateReference()
    {
        do {
            $referenceNo = 'webr-' . date('Ymd') . '-' . date('His');
            $exists = Sale::where('reference_no', $referenceNo)->exists();
        } while ($exists);

        return $referenceNo;
    }

    protected function generateTrackingCode()
    {
        $trackingCode = 'TRK-' . date('Ymd') . '-' . date('His') . '-' . strtoupper(Str::random(3));

        while (OrderTracking::where('tracking_no', $trackingCode)->exists()) {
            $trackingCode = 'TRK-' . date('Ymd') . '-' . date('His') . '-' . strtoupper(Str::random(3));
        }

        return $trackingCode;
    }

    public function store(Request $request)
    {
        DB::beginTransaction();
        try {
            $refNo = $this->generateReference();
            $plainPassword = Str::random(8);
            $customer = Customer::firstOrCreate(
                ['phone_number' => $request->customer['phone']],
                [
                    'name' => $request->customer['name'],
                    'address' => $request->customer['address'],
                    'password' => Hash::make($plainPassword),
                    'customer_group_id' => 1,
                    'points' => 0,
                ],
            );

            $isNewCustomer = $customer->wasRecentlyCreated;

            $sale = Sale::create([
                'reference_no' => $refNo,
                'user_id' => 1,
                'customer_id' => $customer->id,
                'warehouse_id' => 1,
                'sale_type' => 'website',
                'item' => count($request->items),
                'total_qty' => $request->total_qty,
                'total_price' => $request->subtotal,
                'shipping_cost' => $request->shipping_cost,
                'grand_total' => $request->total,
                'sale_status' => $request->sale_status,
                'payment_status' => $request->payment_status,
                'currency_id' => 3,
                'exchange_rate' => 1,
                'paid_amount' => 0,
                'total_discount' => 0,
                'total_tax' => 0,
                'order_discount_type' => $request->order_discount_type ?? null,
                'order_discount_value' => $request->order_discount_value ?? 0,
                'order_discount' => $request->discount_amount ?? 0,
            ]);

            // Add items to Product_Sale
            foreach ($request->items as $item) {
                $product = Product::find($item['product_id']);
                Product_Sale::create([
                    'sale_id' => $sale->id,
                    'product_id' => $item['product_id'],
                    'product_batch_id' => $item['product_batch_id'] ?? null,
                    'variant_id' => $item['variant_id'] ?? null,
                    'imei_number' => $item['imei_number'] ?? null,
                    'qty' => $item['qty'] ?? 0,
                    'return_qty' => $item['return_qty'] ?? 0,
                    'sale_unit_id' => $item['sale_unit_id'] ?? $product->sale_unit_id,
                    'net_unit_price' => $item['net_unit_price'],
                    'discount' => $item['discount'] ?? 0,
                    'tax_rate' => $item['tax_rate'] ?? 0,
                    'tax' => $item['tax'] ?? 0,
                    'total' => $item['total'] ?? 0,
                    // 'is_packing'       => $item['is_packing'] ?? 0,
                    // 'is_delivered'     => $item['is_delivered'] ?? 0,
                    // 'topping_id'       => $item['topping_id'] ?? null,
                ]);
            }

            // Initialize tracking
            $tracking = $sale->tracking()->create([
                'tracking_no' => $this->generateTrackingCode(),
                'status' => 'pending',
            ]);

            // First tracking history entry
            $tracking->histories()->create([
                'status' => 'pending',
                'notes' => 'Order placed',
                'changed_at' => now(),
            ]);

            $settings = RewardPointSetting::first();
            $allTiers = RewardPointTier::all();

            $currentTier = $allTiers->first(function ($tier) use ($customer) {
                return $customer->points >= $tier->min_points && $customer->points <= $tier->max_points;
            });

            if ($request->discount_applied && $currentTier && $currentTier->deduction_enabled && $currentTier->deduction_rate_per_amount > 0) {
                $units = floor($sale->grand_total / $currentTier->deduction_rate_per_amount);

                $pointsToDeduct = $units * $currentTier->deduction_rate_per_unit;

                if ($pointsToDeduct > 0) {
                    $deduct = min($pointsToDeduct, $customer->points);
                    $customer->decrement('points', $deduct);
                    
                    $customer->rewardPointUsages()->create([
                        'order_id' => $sale->id,
                        'tier_id' => $currentTier ? $currentTier->id : null,
                        'points_used' => $pointsToDeduct,
                        'discount_amount'  => $sale->order_discount
                    ]);
                }

            }

            // Add Reward Points 
            if ($settings && $settings->is_active && $settings->minimum_amount <= $sale->grand_total) {
                $earnedPoints = floor($sale->grand_total / $settings->per_point_amount);
                if ($earnedPoints > 0) {
                    $customer->increment('points', $earnedPoints);
                }
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'sale' => $sale,
                'tracking' => $tracking,
                'is_new_customer' => $isNewCustomer,
                'temporary_password' => $isNewCustomer ? $plainPassword : null,
            ]);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json(
                [
                    'success' => false,
                    'message' => $e->getMessage(),
                ],
                500,
            );
        }
    }

    public function getOrder($order_id)
    {
        try {
            $order = Sale::with(['customer', 'productSales.unit', 'tracking.histories'])->findOrFail($order_id);

            $tracking = $order->tracking
                ? [
                    'id' => $order->tracking->id,
                    'tracking_number' => $order->tracking->tracking_no,
                    'current_status' => $order->tracking->current_status,
                    'assigned_rider_id' => $order->tracking->assigned_rider_id,
                    'histories' => $order->tracking->histories->map(function ($history) {
                        return [
                            'id' => $history->id,
                            'status' => $history->status,
                            'notes' => $history->note,
                            'changed_at' => $history->created_at,
                        ];
                    }),
                ]
                : null;

            return response()->json([
                'success' => true,
                'order' => $order,
                'tracking' => $tracking,
            ]);
        } catch (\Exception $e) {
            return response()->json(
                [
                    'success' => false,
                    'message' => $e->getMessage(),
                ],
                404,
            );
        }
    }

    public function getTrackingDetails($tracking_code)
    {
        try {
            $tracking = OrderTracking::with('histories')->where('tracking_no', $tracking_code)->firstOrFail();

            $order = Sale::with(['customer', 'productSales.unit'])
                ->where('id', $tracking->sale_id)
                ->firstOrFail();

            $tracking = $tracking
                ? [
                    'id' => $tracking->id,
                    'tracking_number' => $tracking->tracking_no,
                    'current_status' => $tracking->current_status,
                    'assigned_rider_id' => $tracking->assigned_rider_id,
                    'histories' => $tracking->histories->map(function ($history) {
                        return [
                            'id' => $history->id,
                            'status' => $history->status,
                            'notes' => $history->note,
                            'changed_at' => $history->created_at,
                        ];
                    }),
                ]
                : null;

            return response()->json([
                'success' => true,
                'order' => $order,
                'tracking' => $tracking,
            ]);
        } catch (\Exception $e) {
            return response()->json(
                [
                    'success' => false,
                    'message' => $e->getMessage(),
                ],
                404,
            );
        }
    }

    public static function orderlist($customer){
        $orders = $customer->orders()->with([
            'customer:id,name,phone_number,email',
            'tracking.histories',
            'products' => function ($query) {
                $query->select('products.id', 'name', 'price', 'unit_id')
                    ->with('unit:id,unit_code,unit_name')->withPivot('qty');
            },
        ])
            ->get();

        $orders = $orders->map(function ($order) {
            return [
                'id' => $order->id,
                'date' => $order->created_at->format('Y-m-d'),
                'status' => $order->sale_status == 0 ? 'Processing' : 'Delivered',
                'items' => $order->products ? $order->products->pluck('name')->toArray() : [],
                'total' => $order->grand_total,
                'discount' => [
                    'type' => $order->order_discount_type,
                    'value' => (float) $order->order_discount_value,
                    'amount' => (float) $order->order_discount,
                ],
                'tracking' => $order->tracking ?? null,
            ];
        });

        return $orders;
    }

    public function getOrders(Request $request)
    {
        $customer = auth()->user();
        $orders = $this->orderlist($customer);

        return response()->json([
            'success' => true,
            'data' => $orders
        ]);
    }

    public function getOrderDetail(Request $request, $order_id)
    {
        try {
            $order = Sale::with([
                'customer:id,name,phone_number,email',
                'tracking.histories',
                'products' => function ($query) {
                    $query->select('products.id', 'name', 'price', 'unit_id')
                        ->with('unit:id,unit_code,unit_name')->withPivot('qty');
                },
            ])->find($order_id);

            if (!$order) {
                return response()->json([
                    'success' => false,
                    'message' => 'Order not found.'
                ], 404);
            }

            $products = $order->products->map(function ($product) {
                $qty = $product->pivot->qty ?? 0;
                $unit = $product->unit?->unit_code ?? '';

                return [
                    'id' => $product->id,
                    'name' => $product->name,
                    'price' => (float) $product->price,
                    'quantity' => "{$qty} {$unit}",
                    'subtotal' => (float) $product->price * $qty,
                ];
            });

            $tracking = $order->tracking
                ? [
                    'id' => $order->tracking->id,
                    'tracking_number' => $order->tracking->tracking_no,
                    'current_status' => $order->tracking->current_status,
                    'assigned_rider_id' => $order->tracking->assigned_rider_id,
                    'histories' => $order->tracking->histories->map(function ($history) {
                        return [
                            'status' => $history->status,
                            'notes' => $history->note,
                            'changed_at' => $history->created_at,
                        ];
                    }),
                ]
                : null;

            
            $response = [
                'id' => $order->id,
                'date' => $order->created_at?->format('Y-m-d H:i:s'),
                'status' => $order->status,
                'grand_total' => (float) $order->grand_total,
                'total_price' => (float) $order->total_price,
                'discount' => [
                    'type' => $order->order_discount_type,
                    'value' => (float) $order->order_discount_value,
                    'amount' => (float) $order->order_discount,
                ],
                'shipping_cost' => (float) $order->shipping_cost,
                'paymentMethod' => $order->payment_method,
                'customer' => $order->customer,
                'tracking' => $tracking,
                'items' => $products
            ];

            return response()->json([
                'success' => true,
                'data' => $response
            ]);
        } catch (\Exception $e) {
            Log::error('Get Order Detail Failed: ' . $e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch order details.'
            ], 500);
        }
    }
}
