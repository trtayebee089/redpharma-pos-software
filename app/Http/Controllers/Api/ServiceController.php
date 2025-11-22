<?php

namespace App\Http\Controllers\Api;

use Exception;
use App\Models\ShippingZone;
use Illuminate\Http\Request;
use App\Models\RewardPointTier;
use App\Models\RewardPointUsage;
use App\Models\RewardPointSetting;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\Models\AccountRemovalRequest;
use App\Models\Customer;
use Illuminate\Support\Facades\Validator;

class ServiceController extends Controller
{
    public function getRewardPointTiers()
    {
        try {
            $tiers = RewardPointTier::orderBy('discount_rate', 'asc')->get();
            $settings = RewardPointSetting::first();
            $usages = RewardPointUsage::with('tier')->where('customer_id', auth()->id())->get();

            return response()->json([
                'success'  => true,
                'tiers'    => $tiers,
                'settings' => $settings,
                'usages'   => $usages,
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching reward point tiers: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch reward point tiers',
            ], 500);
        }
    }

    public function shippingZones()
    {
        try {
            $zones = ShippingZone::orderBy('division', 'asc')->get();

            return response()->json([
                'success'  => true,
                'data'    => $zones,
            ]);
        } catch (\Exception $e) {
            Log::error('Error fetching zones: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch zones',
            ], 500);
        }
    }

    public function accountRemovalRequest(Request $request)
    {
        $data = [
            'phone_number' => trim($request->phone_number),
            'issue'        => trim($request->issue),
            'comment'      => trim($request->comment),
        ];
        Log::info($data);
        $validator = Validator::make($data, [
            'issue'        => 'nullable|string|max:255',
            'comment'      => 'nullable|string|max:2000',
            'phone_number' => 'required|string',
        ]);

        if ($validator->fails()) {
            Log::info($validator->errors());
            return response()->json([
                'message' => 'Validation failed',
                'errors'  => $validator->errors(),
            ], 422);
        }

        try {
            $user = Customer::where('phone_number', $data['phone_number'])->first();

            if (!$user) {
                return response()->json([
                    'message' => 'User not found or unauthorized.'
                ], 401);
            }

            $removalRequest = AccountRemovalRequest::where('user_id', $user->id)
                ->latest()
                ->first();

            if ($removalRequest) {
                return response()->json([
                    'message' => 'You have already submitted a removal request. Please wait 30 days.'
                ], 409);
            }

            AccountRemovalRequest::create([
                'user_id' => $user->id,
                'issue'   => $data['issue'],
                'comment' => $data['comment'],
            ]);

            return response()->json([
                'message' => 'Account removal request submitted successfully.'
            ], 200);
        } catch (Exception $e) {
            Log::error('Account removal request error: ' . $e->getMessage());

            return response()->json([
                'message' => 'Failed to submit request.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
}
