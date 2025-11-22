<?php

namespace App\Http\Controllers;

use DB;
use Auth;
use File;
use DNS1D;
use Exception;
use Keygen\Keygen;
use App\Models\Tax;
use App\Models\Unit;
use App\Models\Brand;
use App\Models\Barcode;
use App\Models\Payment;
use App\Models\Product;
use App\Models\Variant;
use App\Models\Category;
use App\Models\Purchase;
use App\Models\Supplier;
use App\Models\Warehouse;
use App\Traits\TenantInfo;
use App\Models\CustomField;
use App\Traits\CacheForget;
use Illuminate\Support\Str;
use App\Models\ProductBatch;
use Illuminate\Http\Request;
use App\Models\ProductVariant;
use App\Models\ProductPurchase;
use Illuminate\Validation\Rule;
use App\Models\Product_Supplier;
use App\Models\Product_Warehouse;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Http;
use Intervention\Image\Colors\Rgb\Channels\Red;
use Intervention\Image\ImageManager;
use Spatie\Permission\Models\Permission;
use Intervention\Image\Drivers\Gd\Driver;
use Yajra\DataTables\Facades\DataTables;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Csv;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use Illuminate\Support\Facades\Cache;

class ProductController extends Controller
{
    use CacheForget;
    use TenantInfo;

    public function getSearchLibrary(Request $request)
    {
        $term = $request->search;

        $products = Product::select('id', 'name', 'code', 'qty', 'unit_id', 'brand_id', 'category_id', 'price', 'cost')
            ->with([
                'unit:id,unit_code',
                'category:id,name',
                'brand:id,title'
            ])
            ->where('is_active', true)
            ->whereNotNull('price')
            ->where('price', '>', 0)
            ->where(function ($query) use ($term) {
                $query->where('name', 'like', "%{$term}%")
                    ->orWhere('code', 'like', "%{$term}%");
            })
            ->limit(20)
            ->get();

        $results = $products->map(function ($item) {
            $unitCode = optional($item->unit)->unit_code;
            return [
                'id'       => $item->code,
                'name'     => $item->name,
                'code'     => $item->code,
                'quantity' => $item->qty . ' ' . optional($item->unit)->unit_code,
                'category' => optional($item->category)->name,
                'brand'    => optional($item->brand)->title,
                'price'    => $item->price . ' / ' . optional($item->unit)->unit_code,
                'cost'     => $item->cost . ' / ' . optional($item->unit)->unit_code,
            ];
        });

        return response()->json($results);
    }

    public function index11(Request $request)
    {
        $role = Role::find(Auth::user()->role_id);
        if ($role->hasPermissionTo('products-index')) {
            $lims_warehouse_list = Warehouse::where('is_active', true)->get();

            if ($request->input('warehouse_id'))
                $warehouse_id = $request->input('warehouse_id');
            else
                $warehouse_id = 0;

            $permissions = Role::findByName($role->name)->permissions;

            foreach ($permissions as $permission)
                $all_permission[] = $permission->name;
            if (empty($all_permission))
                $all_permission[] = 'dummy text';
            $role_id = $role->id;
            $numberOfProduct = DB::table('products')->where('is_active', true)->count();
            $custom_fields = CustomField::where([
                ['belongs_to', 'product'],
                ['is_table', true]
            ])->pluck('name');
            $field_name = [];
            foreach ($custom_fields as $fieldName) {
                $field_name[] = str_replace(" ", "_", strtolower($fieldName));
            }

            $lims_category_list = Category::where('is_active', true)->get();
            return view('backend.product.index', compact('warehouse_id', 'all_permission', 'lims_category_list', 'role_id', 'numberOfProduct', 'custom_fields', 'field_name', 'lims_warehouse_list'));
        } else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function index(Request $request)
    {
        $user = Auth::user();
        $role = Role::with('permissions')->find($user->role_id);
        if (!$role || !$role->hasPermissionTo('products-index')) {
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
        }
        $warehouse_id = $request->input('warehouse_id', 0);
        $all_permission = $role->permissions->pluck('name')->toArray();
        if (empty($all_permission)) $all_permission[] = 'dummy text';
        $role_id = $role->id;
        $numberOfProduct = Cache::remember('active_products_count', 300, function () {
            return DB::table('products')->where('is_active', true)->count();
        });

        $custom_fields = CustomField::where([
            ['belongs_to', 'product'],
            ['is_table', true]
        ])->pluck('name');

        $field_name = $custom_fields->map(fn($name) => str_replace(' ', '_', strtolower($name)));

        $lims_warehouse_list = Warehouse::select('id', 'name')->where('is_active', true)->get();
        $lims_category_list = Category::select('id', 'name')->where('is_active', true)->get();
        //  dd(DB::getQueryLog());
        return view('backend.product.index', compact(
            'warehouse_id',
            'all_permission',
            'lims_category_list',
            'role_id',
            'numberOfProduct',
            'custom_fields',
            'field_name',
            'lims_warehouse_list'
        ));
    }


    public function productData__(Request $request)
    {
        // $warehouse_id = $request->input('warehouse_id');
        $category = $request->input('category_id');

        // Get total count without filtering
        $totalData = DB::table('products')->where('is_active', true)->count();
        $totalFiltered = $totalData;

        $query = Product::with('category', 'brand', 'unit')->where('is_active', true);

        if ($category && $category != 0) {
            $query->where('category_id', $category);
        }

        // if ($warehouse_id && $warehouse_id != 0) {
        //     $query->whereHas('warehouses', function ($q) use ($warehouse_id) {
        //         $q->where('warehouse_id', $warehouse_id);
        //     });
        // }

        if (empty($request->input('search.value'))) {
            $products = $query->get();

            $totalFiltered = $query->count();
        } else {
            $search = $request->input('search.value');

            $q = Product::select('products.*')
                ->distinct()
                ->with('category', 'brand', 'unit')
                ->join('categories', 'products.category_id', '=', 'categories.id')
                ->leftJoin('brands', 'products.brand_id', '=', 'brands.id')
                ->leftJoin('product_variants', 'products.id', '=', 'product_variants.product_id')
                ->leftJoin('product_warehouse', 'products.id', '=', 'product_warehouse.product_id')
                ->leftJoin('warehouses', 'product_warehouse.warehouse_id', '=', 'warehouses.id')
                ->where([
                    ['products.name', 'LIKE', "%{$search}%"],
                    ['products.is_active', true]
                ])
                ->orWhere([
                    ['products.code', 'LIKE', "%{$search}%"],
                    ['products.is_active', true]
                ])
                ->orWhere([
                    ['categories.name', 'LIKE', "%{$search}%"],
                    ['categories.is_active', true],
                    ['products.is_active', true]
                ])
                ->orWhere([
                    ['brands.title', 'LIKE', "%{$search}%"],
                    ['brands.is_active', true],
                    ['products.is_active', true]
                ]);

            $products = $q->get();

            $totalFiltered = $q->count();
        }

        $data = [];
        if ($products->isNotEmpty()) {
            foreach ($products as $key => $product) {
                $nestedData['id'] = $product->id;
                $nestedData['key'] = $key;
                $product_image = explode(",", $product->image);
                $nestedData['image'] = htmlspecialchars($product_image[0]);
                $nestedData['name'] = $product->name;
                $nestedData['code'] = $product->code;
                $nestedData['brand'] = $product->brand ? $product->brand->title : "N/A";
                $nestedData['category'] = $product->category->name;
                $unitCode = $product->unit_id ? $product->unit->unit_code : '';

                // if ($warehouse_id > 0) {
                //     $nestedData['qty'] = Product_Warehouse::where([['product_id', $product->id], ['warehouse_id', $warehouse_id]])->sum('qty') . ' ' . $unitCode;
                // } else {
                // }
                $nestedData['qty'] = $product->qty . ' ' . $unitCode;

                $nestedData['unit'] = $product->unit_id ? $product->unit->unit_code : '';
                $nestedData['price'] = $product->price;
                $nestedData['cost'] = $product->cost;
                $nestedData['expire_date'] = $product->expire_date ? \Carbon\Carbon::parse($product->expire_date)->format('d M, Y') : "N/A";

                $nestedData['options'] = '<div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-cogs"></i>
                                <span class="caret"></span>
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>

                            <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu">
                            <li>
                                <button="type" class="btn btn-link view"><i class="fa fa-eye"></i> ' . trans('file.View') . '</button>
                            </li>';

                if (in_array("products-edit", $request['all_permission']))
                    $nestedData['options'] .= '<li>
                            <a href="' . route('products.edit', $product->id) . '" class="btn btn-link"><i class="fa fa-edit"></i> ' . trans('file.edit') . '</a>
                        </li>';
                if (in_array("product_history", $request['all_permission']))
                    $nestedData['options'] .= '<form action="' . route("products.history") . '" method="GET">' . '
                            <li>
                                <input type="hidden" name="product_id" value="' . $product->id . '" />
                                <button type="submit" class="btn btn-link"><i class="dripicons-checklist"></i> ' . trans("file.Product History") . '</button>
                            </li></form>';
                if (in_array("print_barcode", $request['all_permission'])) {
                    $product_info = $product->code . ' (' . $product->name . ')';
                    $nestedData['options'] .= '<form action="' . route("product.printBarcode") . '" method="GET">' . '
                        <li>
                            <input type="hidden" name="data" value="' . $product_info . '" />
                            <button type="submit" class="btn btn-link"><i class="dripicons-print"></i> ' . trans("file.print_barcode") . '</button>
                        </li></form>';
                }
                if (in_array("products-delete", $request['all_permission']))
                    $nestedData['options'] .= '<form action="' . route('products.destroy', $product->id) . '" method="POST">
                            ' . csrf_field() . '
                            <input type="hidden" name="_method" value="DELETE">
                            <li>
                                <button type="submit" class="btn btn-link" onclick="return confirmDelete()">
                                    <i class="fa fa-trash"></i> ' . trans("file.delete") . '
                                </button>
                            </li>
                        </form>
                        </ul>
                    </div>';

                $data[] = $nestedData;
            }
        }

        return DataTables::of($data)
            ->addIndexColumn()
            ->addColumn('options', function ($row) {
                $btn = isset($row['options']) ? $row['options'] : '';
                return $btn;
            })
            ->with('recordsTotal', $totalData)
            ->with('recordsFiltered', $totalFiltered)
            ->rawColumns(['options'])
            ->make(true);
    }

    public function productData(Request $request)
    {
        $category = $request->input('category_id');
        $search = $request->input('search.value');
        $limit = $request->input('length');
        $start = $request->input('start');

        $baseQuery = Product::with(['category:id,name', 'brand:id,title', 'unit:id,unit_code'])
            ->select('id', 'name', 'code', 'image', 'brand_id', 'category_id', 'unit_id', 'price', 'cost', 'expire_date', 'qty')
            ->where('is_active', true);

        if ($category && $category != 0) {
            $baseQuery->where('category_id', $category);
        }

        // Search Filtering
        if (!empty($search)) {
            $baseQuery->where(function ($query) use ($search) {
                $query->where('products.name', 'LIKE', "%{$search}%")
                    ->orWhere('products.code', 'LIKE', "%{$search}%")
                    ->orWhereHas('category', function ($q) use ($search) {
                        $q->where('name', 'LIKE', "%{$search}%")->where('is_active', true);
                    })
                    ->orWhereHas('brand', function ($q) use ($search) {
                        $q->where('title', 'LIKE', "%{$search}%")->where('is_active', true);
                    });
            });
        }

        return DataTables::of($baseQuery)
            ->addIndexColumn() // Adds DT_RowIndex
            ->addColumn('key', function ($product) {
                return $product->id;
            })
            ->editColumn('image', function ($product) {
                $images = explode(',', $product->image);
                return htmlspecialchars($images[0] ?? '');
            })
            ->addColumn('brand', function ($product) {
                return $product->brand->title ?? 'N/A';
            })
            ->addColumn('category', function ($product) {
                return $product->category->name ?? 'N/A';
            })
            ->addColumn('qty', function ($product) {
                return $product->qty . ' ' . ($product->unit->unit_code ?? '');
            })
            ->addColumn('unit', function ($product) {
                return $product->unit->unit_code ?? '';
            })
            ->addColumn('expire_date', function ($product) {
                return $product->expire_date ? \Carbon\Carbon::parse($product->expire_date)->format('d M, Y') : 'N/A';
            })
            ->addColumn('options', function ($product) use ($request) {
                return $this->getProductActionButtons($product, $request['all_permission']);
            })
            ->rawColumns(['options']) // Needed for HTML buttons
            ->make(true);
    }

    private function getProductActionButtons($product, $permissions)
    {
        $buttons = '<div class="btn-group">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fa fa-cogs"></i>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu edit-options dropdown-menu-right">';

        $buttons .= '<li><button type="button" class="btn btn-link view"><i class="fa fa-eye"></i> View</button></li>';

        if (in_array('products-edit', $permissions)) {
            $buttons .= '<li><a href="' . route('products.edit', $product->id) . '" class="btn btn-link"><i class="fa fa-edit"></i> Edit</a></li>';
        }

        if (in_array('product_history', $permissions)) {
            $buttons .= '<form action="' . route('products.history') . '" method="GET">
                <li><input type="hidden" name="product_id" value="' . $product->id . '">
                <button type="submit" class="btn btn-link"><i class="dripicons-checklist"></i> History</button></li></form>';
        }

        if (in_array('print_barcode', $permissions)) {
            $info = $product->code . ' (' . $product->name . ')';
            $buttons .= '<form action="' . route('product.printBarcode') . '" method="GET">
                <li><input type="hidden" name="data" value="' . $info . '">
                <button type="submit" class="btn btn-link"><i class="dripicons-print"></i> Barcode</button></li></form>';
        }

        if (in_array('products-delete', $permissions)) {
            $buttons .= '<form action="' . route('products.destroy', $product->id) . '" method="POST">' .
                csrf_field() . '<input type="hidden" name="_method" value="DELETE">
                <li><button type="submit" class="btn btn-link" onclick="return confirmDelete()"><i class="fa fa-trash"></i> Delete</button></li></form>';
        }

        $buttons .= '</ul></div>';

        return $buttons;
    }
    public function create()
    {
        $role = Role::firstOrCreate(['id' => Auth::user()->role_id]);
        if ($role->hasPermissionTo('products-add')) {
            $lims_product_list_without_variant = $this->productWithoutVariant();
            $lims_product_list_with_variant = $this->productWithVariant();
            $lims_brand_list = Brand::where('is_active', true)->get();
            $lims_category_list = Category::where('is_active', true)->get();
            $lims_unit_list = Unit::where('is_active', true)->get();
            $lims_tax_list = Tax::where('is_active', true)->get();
            $lims_warehouse_list = Warehouse::where('is_active', true)->get();
            $numberOfProduct = Product::where('is_active', true)->count();
            $custom_fields = CustomField::where('belongs_to', 'product')->get();
            return view('backend.product.create', compact('lims_product_list_without_variant', 'lims_product_list_with_variant', 'lims_brand_list', 'lims_category_list', 'lims_unit_list', 'lims_tax_list', 'lims_warehouse_list', 'numberOfProduct', 'custom_fields'));
        } else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'code' => [
                'max:255',
                Rule::unique('products')->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ],
            'name' => [
                'max:255',
                Rule::unique('products')->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ]
        ]);

        $data = $request->except('image', 'file');
        $data['name'] = preg_replace('/[\n\r]/', "<br>", htmlspecialchars(trim($data['name']), ENT_QUOTES));
        $data['product_details'] = str_replace('"', '@', $data['product_details']);
        $data['is_active'] = true;
        $data['expire_date'] = $request->expire_date;
        $data['image'] = 'zummXD2dvAtI.png';
        $data['featured'] = 1;

        $lims_product_data = Product::create($data);

        $initial_stock = 0;
        if (isset($data['stock_warehouse_id'])) {
            foreach ($data['stock_warehouse_id'] as $key => $warehouse_id) {
                $stock = $data['stock'][$key];
                if ($stock > 0) {
                    $this->autoPurchase($lims_product_data, $warehouse_id, $stock);
                    $initial_stock += $stock;
                }
            }
        }

        if ($initial_stock > 0) {
            $lims_product_data->qty += $initial_stock;
            $lims_product_data->save();
        }

        $this->cacheForget('product_list');
        $this->cacheForget('product_list_with_variant');
        \Session::flash('create_message', 'Product created successfully');
    }

    public function autoPurchase($product_data, $warehouse_id, $stock)
    {
        $data['reference_no'] = 'pr-' . date("Ymd") . '-' . date("his");
        $data['user_id'] = Auth::id();
        $data['warehouse_id'] = $warehouse_id;
        $data['item'] = 1;
        $data['total_qty'] = $stock;
        $data['total_discount'] = 0;
        $data['status'] = 1;
        $data['payment_status'] = 2;
        if ($product_data->tax_id) {
            $tax_data = DB::table('taxes')->select('rate')->find($product_data->tax_id);
            if ($product_data->tax_method == 1) {
                $net_unit_cost = number_format($product_data->cost, 2, '.', '');
                $tax = number_format($product_data->cost * $stock * ($tax_data->rate / 100), 2, '.', '');
                $cost = number_format(($product_data->cost * $stock) + $tax, 2, '.', '');
            } else {
                $net_unit_cost = number_format((100 / (100 + $tax_data->rate)) * $product_data->cost, 2, '.', '');
                $tax = number_format(($product_data->cost - $net_unit_cost) * $stock, 2, '.', '');
                $cost = number_format($product_data->cost * $stock, 2, '.', '');
            }
            $tax_rate = $tax_data->rate;
            $data['total_tax'] = $tax;
            $data['total_cost'] = $cost;
        } else {
            $data['total_tax'] = 0.00;
            $data['total_cost'] = number_format($product_data->cost * $stock, 2, '.', '');
            $net_unit_cost = number_format($product_data->cost, 2, '.', '');
            $tax_rate = 0.00;
            $tax = 0.00;
            $cost = number_format($product_data->cost * $stock, 2, '.', '');
        }

        $product_warehouse_data = Product_Warehouse::select('id', 'qty')
            ->where([
                ['product_id', $product_data->id],
                ['warehouse_id', $warehouse_id]
            ])->first();
        if ($product_warehouse_data) {
            $product_warehouse_data->qty += $stock;
            $product_warehouse_data->save();
        } else {
            $lims_product_warehouse_data = new Product_Warehouse();
            $lims_product_warehouse_data->product_id = $product_data->id;
            $lims_product_warehouse_data->warehouse_id = $warehouse_id;
            $lims_product_warehouse_data->qty = $stock;
            $lims_product_warehouse_data->save();
        }
        $data['order_tax'] = 0;
        $data['grand_total'] = $data['total_cost'];
        $data['paid_amount'] = $data['grand_total'];
        //insetting data to purchase table
        $purchase_data = Purchase::create($data);
        //inserting data to product_purchases table
        ProductPurchase::create([
            'purchase_id' => $purchase_data->id,
            'product_id' => $product_data->id,
            'qty' => $stock,
            'recieved' => $stock,
            'purchase_unit_id' => $product_data->unit_id,
            'net_unit_cost' => $net_unit_cost,
            'discount' => 0,
            'tax_rate' => $tax_rate,
            'tax' => $tax,
            'total' => $cost
        ]);
        //inserting data to payments table
        Payment::create([
            'payment_reference' => 'ppr-' . date("Ymd") . '-' . date("his"),
            'user_id' => Auth::id(),
            'purchase_id' => $purchase_data->id,
            'account_id' => 0,
            'amount' => $data['grand_total'],
            'change' => 0,
            'paying_method' => 'Cash'
        ]);
    }

    public function history(Request $request)
    {
        $role = Role::find(Auth::user()->role_id);
        if ($role->hasPermissionTo('product_history')) {
            if ($request->input('warehouse_id'))
                $warehouse_id = $request->input('warehouse_id');
            else
                $warehouse_id = 0;

            if ($request->input('starting_date')) {
                $starting_date = $request->input('starting_date');
                $ending_date = $request->input('ending_date');
            } else {
                $starting_date = date("Y-m-d", strtotime(date('Y-m-d', strtotime('-1 year', strtotime(date('Y-m-d'))))));
                $ending_date = date("Y-m-d");
            }
            $product_id = $request->input('product_id');
            $product_data = Product::select('name', 'code')->find($product_id);
            $lims_warehouse_list = Warehouse::where('is_active', true)->get();
            return view('backend.product.history', compact('starting_date', 'ending_date', 'warehouse_id', 'product_id', 'product_data', 'lims_warehouse_list'));
        } else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function saleHistoryData(Request $request)
    {
        $columns = array(
            1 => 'created_at',
            2 => 'reference_no',
        );

        $product_id = $request->input('product_id');
        $warehouse_id = $request->input('warehouse_id');

        $q = DB::table('sales')
            ->join('product_sales', 'sales.id', '=', 'product_sales.sale_id')
            ->where('product_sales.product_id', $product_id)
            ->whereDate('sales.created_at', '>=', $request->input('starting_date'))
            ->whereDate('sales.created_at', '<=', $request->input('ending_date'));
        if ($warehouse_id)
            $q = $q->where('warehouse_id', $warehouse_id);
        if (Auth::user()->role_id > 2 && config('staff_access') == 'own')
            $q = $q->where('sales.user_id', Auth::id());

        $totalData = $q->count();
        $totalFiltered = $totalData;

        if ($request->input('length') != -1)
            $limit = $request->input('length');
        else
            $limit = $totalData;
        $start = $request->input('start');
        $order = 'sales.' . $columns[$request->input('order.0.column')];
        $dir = $request->input('order.0.dir');
        $q = $q->join('customers', 'sales.customer_id', '=', 'customers.id')
            ->join('warehouses', 'sales.warehouse_id', '=', 'warehouses.id')
            ->select('sales.id', 'sales.reference_no', 'sales.created_at', 'customers.name as customer_name', 'customers.phone_number as customer_number', 'warehouses.name as warehouse_name', 'product_sales.qty', 'product_sales.sale_unit_id', 'product_sales.total')
            ->offset($start)
            ->limit($limit)
            ->orderBy($order, $dir);
        if (empty($request->input('search.value'))) {
            $sales = $q->get();
        } else {
            $search = $request->input('search.value');
            $q = $q->whereDate('sales.created_at', '=', date('Y-m-d', strtotime(str_replace('/', '-', $search))));
            if (Auth::user()->role_id > 2 && config('staff_access') == 'own') {
                $sales =  $q->orwhere([
                    ['sales.reference_no', 'LIKE', "%{$search}%"],
                    ['sales.user_id', Auth::id()]
                ])
                    ->get();
                $totalFiltered = $q->orwhere([
                    ['sales.reference_no', 'LIKE', "%{$search}%"],
                    ['sales.user_id', Auth::id()]
                ])
                    ->count();
            } else {
                $sales =  $q->orwhere('sales.reference_no', 'LIKE', "%{$search}%")->get();
                $totalFiltered = $q->orwhere('sales.reference_no', 'LIKE', "%{$search}%")->count();
            }
        }
        $data = array();
        if (!empty($sales)) {
            foreach ($sales as $key => $sale) {
                $nestedData['id'] = $sale->id;
                $nestedData['key'] = $key;
                $nestedData['date'] = date(config('date_format'), strtotime($sale->created_at));
                $nestedData['reference_no'] = $sale->reference_no;
                $nestedData['warehouse'] = $sale->warehouse_name;
                $nestedData['customer'] = $sale->customer_name . ' [' . ($sale->customer_number) . ']';
                $nestedData['qty'] = number_format($sale->qty, config('decimal'));
                if ($sale->sale_unit_id) {
                    $unit_data = DB::table('units')->select('unit_code')->find($sale->sale_unit_id);
                    $nestedData['qty'] .= ' ' . $unit_data->unit_code;
                }
                $nestedData['unit_price'] = number_format(($sale->total / $sale->qty), config('decimal'));
                $nestedData['sub_total'] = number_format($sale->total, config('decimal'));
                $data[] = $nestedData;
            }
        }
        $json_data = array(
            "draw"            => intval($request->input('draw')),
            "recordsTotal"    => intval($totalData),
            "recordsFiltered" => intval($totalFiltered),
            "data"            => $data
        );
        echo json_encode($json_data);
    }

    public function purchaseHistoryData(Request $request)
    {
        $columns = array(
            1 => 'created_at',
            2 => 'reference_no',
        );

        $product_id = $request->input('product_id');
        $warehouse_id = $request->input('warehouse_id');

        $q = DB::table('purchases')
            ->join('product_purchases', 'purchases.id', '=', 'product_purchases.purchase_id')
            ->where('product_purchases.product_id', $product_id)
            ->whereDate('purchases.created_at', '>=', $request->input('starting_date'))
            ->whereDate('purchases.created_at', '<=', $request->input('ending_date'));
        if ($warehouse_id)
            $q = $q->where('warehouse_id', $warehouse_id);
        if (Auth::user()->role_id > 2 && config('staff_access') == 'own')
            $q = $q->where('purchases.user_id', Auth::id());

        $totalData = $q->count();
        $totalFiltered = $totalData;

        if ($request->input('length') != -1)
            $limit = $request->input('length');
        else
            $limit = $totalData;
        $start = $request->input('start');
        $order = 'purchases.' . $columns[$request->input('order.0.column')];
        $dir = $request->input('order.0.dir');
        $q = $q->leftJoin('suppliers', 'purchases.supplier_id', '=', 'suppliers.id')
            ->join('warehouses', 'purchases.warehouse_id', '=', 'warehouses.id')
            ->offset($start)
            ->limit($limit)
            ->orderBy($order, $dir);
        if (empty($request->input('search.value'))) {
            $purchases = $q->select('purchases.id', 'purchases.reference_no', 'purchases.created_at', 'purchases.supplier_id', 'suppliers.name as supplier_name', 'suppliers.phone_number as supplier_number', 'warehouses.name as warehouse_name', 'product_purchases.qty', 'product_purchases.purchase_unit_id', 'product_purchases.total')->get();
        } else {
            $search = $request->input('search.value');
            $q = $q->whereDate('purchases.created_at', '=', date('Y-m-d', strtotime(str_replace('/', '-', $search))));
            if (Auth::user()->role_id > 2 && config('staff_access') == 'own') {
                $purchases =  $q->select('purchases.id', 'purchases.reference_no', 'purchases.created_at', 'purchases.supplier_id', 'suppliers.name as supplier_name', 'suppliers.phone_number as supplier_number', 'warehouses.name as warehouse_name', 'product_purchases.qty', 'product_purchases.purchase_unit_id', 'product_purchases.total')
                    ->orwhere([
                        ['purchases.reference_no', 'LIKE', "%{$search}%"],
                        ['purchases.user_id', Auth::id()]
                    ])->get();
                $totalFiltered = $q->orwhere([
                    ['purchases.reference_no', 'LIKE', "%{$search}%"],
                    ['purchases.user_id', Auth::id()]
                ])->count();
            } else {
                $purchases =  $q->select('purchases.id', 'purchases.reference_no', 'purchases.created_at', 'purchases.supplier_id', 'suppliers.name as supplier_name', 'suppliers.phone_number as supplier_number', 'warehouses.name as warehouse_name', 'product_purchases.qty', 'product_purchases.purchase_unit_id', 'product_purchases.total')
                    ->orwhere('purchases.reference_no', 'LIKE', "%{$search}%")
                    ->get();
                $totalFiltered = $q->orwhere('purchases.reference_no', 'LIKE', "%{$search}%")->count();
            }
        }
        $data = array();
        if (!empty($purchases)) {
            foreach ($purchases as $key => $purchase) {
                $nestedData['id'] = $purchase->id;
                $nestedData['key'] = $key;
                $nestedData['date'] = date(config('date_format'), strtotime($purchase->created_at));
                $nestedData['reference_no'] = $purchase->reference_no;
                $nestedData['warehouse'] = $purchase->warehouse_name;
                if ($purchase->supplier_id)
                    $nestedData['supplier'] = $purchase->supplier_name . ' [' . ($purchase->supplier_number) . ']';
                else
                    $nestedData['supplier'] = 'N/A';
                $nestedData['qty'] = number_format($purchase->qty, config('decimal'));
                if ($purchase->purchase_unit_id) {
                    $unit_data = DB::table('units')->select('unit_code')->find($purchase->purchase_unit_id);
                    $nestedData['qty'] .= ' ' . $unit_data->unit_code;
                }
                $nestedData['unit_cost'] = number_format(($purchase->total / $purchase->qty), config('decimal'));
                $nestedData['sub_total'] = number_format($purchase->total, config('decimal'));
                $data[] = $nestedData;
            }
        }
        $json_data = array(
            "draw"            => intval($request->input('draw')),
            "recordsTotal"    => intval($totalData),
            "recordsFiltered" => intval($totalFiltered),
            "data"            => $data
        );
        echo json_encode($json_data);
    }

    public function saleReturnHistoryData(Request $request)
    {
        $columns = array(
            1 => 'created_at',
            2 => 'reference_no',
        );

        $product_id = $request->input('product_id');
        $warehouse_id = $request->input('warehouse_id');

        $q = DB::table('returns')
            ->join('product_returns', 'returns.id', '=', 'product_returns.return_id')
            ->where('product_returns.product_id', $product_id)
            ->whereDate('returns.created_at', '>=', $request->input('starting_date'))
            ->whereDate('returns.created_at', '<=', $request->input('ending_date'));
        if ($warehouse_id)
            $q = $q->where('warehouse_id', $warehouse_id);
        if (Auth::user()->role_id > 2 && config('staff_access') == 'own')
            $q = $q->where('returns.user_id', Auth::id());

        $totalData = $q->count();
        $totalFiltered = $totalData;

        if ($request->input('length') != -1)
            $limit = $request->input('length');
        else
            $limit = $totalData;
        $start = $request->input('start');
        $order = 'returns.' . $columns[$request->input('order.0.column')];
        $dir = $request->input('order.0.dir');
        $q = $q->join('customers', 'returns.customer_id', '=', 'customers.id')
            ->join('warehouses', 'returns.warehouse_id', '=', 'warehouses.id')
            ->offset($start)
            ->limit($limit)
            ->orderBy($order, $dir);
        if (empty($request->input('search.value'))) {
            $returnss = $q->select('returns.id', 'returns.reference_no', 'returns.created_at', 'customers.name as customer_name', 'customers.phone_number as customer_number', 'warehouses.name as warehouse_name', 'product_returns.qty', 'product_returns.sale_unit_id', 'product_returns.total')->get();
        } else {
            $search = $request->input('search.value');
            $q = $q->whereDate('returns.created_at', '=', date('Y-m-d', strtotime(str_replace('/', '-', $search))));
            if (Auth::user()->role_id > 2 && config('staff_access') == 'own') {
                $returnss =  $q->select('returns.id', 'returns.reference_no', 'returns.created_at', 'customers.name as customer_name', 'customers.phone_number as customer_number', 'warehouses.name as warehouse_name', 'product_returns.qty', 'product_returns.sale_unit_id', 'product_returns.total')
                    ->orwhere([
                        ['returns.reference_no', 'LIKE', "%{$search}%"],
                        ['returns.user_id', Auth::id()]
                    ])
                    ->get();
                $totalFiltered = $q->orwhere([
                    ['returns.reference_no', 'LIKE', "%{$search}%"],
                    ['returns.user_id', Auth::id()]
                ])
                    ->count();
            } else {
                $returnss =  $q->select('returns.id', 'returns.reference_no', 'returns.created_at', 'customers.name as customer_name', 'customers.phone_number as customer_number', 'warehouses.name as warehouse_name', 'product_returns.qty', 'product_returns.sale_unit_id', 'product_returns.total')
                    ->orwhere('returns.reference_no', 'LIKE', "%{$search}%")
                    ->get();
                $totalFiltered = $q->orwhere('returns.reference_no', 'LIKE', "%{$search}%")->count();
            }
        }
        $data = array();
        if (!empty($returnss)) {
            foreach ($returnss as $key => $returns) {
                $nestedData['id'] = $returns->id;
                $nestedData['key'] = $key;
                $nestedData['date'] = date(config('date_format'), strtotime($returns->created_at));
                $nestedData['reference_no'] = $returns->reference_no;
                $nestedData['warehouse'] = $returns->warehouse_name;
                $nestedData['customer'] = $returns->customer_name . ' [' . ($returns->customer_number) . ']';
                $nestedData['qty'] = number_format($returns->qty, config('decimal'));
                if ($returns->sale_unit_id) {
                    $unit_data = DB::table('units')->select('unit_code')->find($returns->sale_unit_id);
                    $nestedData['qty'] .= ' ' . $unit_data->unit_code;
                }
                $nestedData['unit_price'] = number_format(($returns->total / $returns->qty), config('decimal'));
                $nestedData['sub_total'] = number_format($returns->total, config('decimal'));
                $data[] = $nestedData;
            }
        }
        $json_data = array(
            "draw"            => intval($request->input('draw')),
            "recordsTotal"    => intval($totalData),
            "recordsFiltered" => intval($totalFiltered),
            "data"            => $data
        );
        echo json_encode($json_data);
    }

    public function purchaseReturnHistoryData(Request $request)
    {
        $columns = array(
            1 => 'created_at',
            2 => 'reference_no',
        );

        $product_id = $request->input('product_id');
        $warehouse_id = $request->input('warehouse_id');

        $q = DB::table('return_purchases')
            ->join('purchase_product_return', 'return_purchases.id', '=', 'purchase_product_return.return_id')
            ->where('purchase_product_return.product_id', $product_id)
            ->whereDate('return_purchases.created_at', '>=', $request->input('starting_date'))
            ->whereDate('return_purchases.created_at', '<=', $request->input('ending_date'));
        if ($warehouse_id)
            $q = $q->where('warehouse_id', $warehouse_id);
        if (Auth::user()->role_id > 2 && config('staff_access') == 'own')
            $q = $q->where('return_purchases.user_id', Auth::id());

        $totalData = $q->count();
        $totalFiltered = $totalData;

        if ($request->input('length') != -1)
            $limit = $request->input('length');
        else
            $limit = $totalData;
        $start = $request->input('start');
        $order = 'return_purchases.' . $columns[$request->input('order.0.column')];
        $dir = $request->input('order.0.dir');
        $q = $q->leftJoin('suppliers', 'return_purchases.supplier_id', '=', 'suppliers.id')
            ->join('warehouses', 'return_purchases.warehouse_id', '=', 'warehouses.id')
            ->select('return_purchases.id', 'return_purchases.reference_no', 'return_purchases.created_at', 'return_purchases.supplier_id', 'suppliers.name as supplier_name', 'suppliers.phone_number as supplier_number', 'warehouses.name as warehouse_name', 'purchase_product_return.qty', 'purchase_product_return.purchase_unit_id', 'purchase_product_return.total')
            ->offset($start)
            ->limit($limit)
            ->orderBy($order, $dir);
        if (empty($request->input('search.value'))) {
            $return_purchases = $q->get();
        } else {
            $search = $request->input('search.value');
            $q = $q->whereDate('return_purchases.created_at', '=', date('Y-m-d', strtotime(str_replace('/', '-', $search))));

            if (Auth::user()->role_id > 2 && config('staff_access') == 'own') {
                $return_purchases =  $q->orwhere([
                    ['return_purchases.reference_no', 'LIKE', "%{$search}%"],
                    ['return_purchases.user_id', Auth::id()]
                ])
                    ->get();
                $totalFiltered = $q->orwhere([
                    ['return_purchases.reference_no', 'LIKE', "%{$search}%"],
                    ['return_purchases.user_id', Auth::id()]
                ])
                    ->count();
            } else {
                $return_purchases =  $q->orwhere('return_purchases.reference_no', 'LIKE', "%{$search}%")->get();
                $totalFiltered = $q->orwhere('return_purchases.reference_no', 'LIKE', "%{$search}%")->count();
            }
        }
        $data = array();
        if (!empty($return_purchases)) {
            foreach ($return_purchases as $key => $return_purchase) {
                $nestedData['id'] = $return_purchase->id;
                $nestedData['key'] = $key;
                $nestedData['date'] = date(config('date_format'), strtotime($return_purchase->created_at));
                $nestedData['reference_no'] = $return_purchase->reference_no;
                $nestedData['warehouse'] = $return_purchase->warehouse_name;
                if ($return_purchase->supplier_id)
                    $nestedData['supplier'] = $return_purchase->supplier_name . ' [' . ($return_purchase->supplier_number) . ']';
                else
                    $nestedData['supplier'] = 'N/A';
                $nestedData['qty'] = number_format($return_purchase->qty, config('decimal'));
                if ($return_purchase->purchase_unit_id) {
                    $unit_data = DB::table('units')->select('unit_code')->find($return_purchase->purchase_unit_id);
                    $nestedData['qty'] .= ' ' . $unit_data->unit_code;
                }
                $nestedData['unit_cost'] = number_format(($return_purchase->total / $return_purchase->qty), config('decimal'));
                $nestedData['sub_total'] = number_format($return_purchase->total, config('decimal'));
                $data[] = $nestedData;
            }
        }
        $json_data = array(
            "draw"            => intval($request->input('draw')),
            "recordsTotal"    => intval($totalData),
            "recordsFiltered" => intval($totalFiltered),
            "data"            => $data
        );
        echo json_encode($json_data);
    }

    public function variantData($id)
    {
        if (Auth::user()->role_id > 2) {
            return ProductVariant::join('variants', 'product_variants.variant_id', '=', 'variants.id')
                ->join('product_warehouse', function ($join) {
                    $join->on('product_variants.product_id', '=', 'product_warehouse.product_id');
                    $join->on('product_variants.variant_id', '=', 'product_warehouse.variant_id');
                })
                ->select('variants.name', 'product_variants.item_code', 'product_variants.additional_cost', 'product_variants.additional_price', 'product_warehouse.qty')
                ->where([
                    ['product_warehouse.product_id', $id],
                    ['product_warehouse.warehouse_id', Auth::user()->warehouse_id]
                ])
                ->orderBy('product_variants.position')
                ->get();
        } else {
            return ProductVariant::join('variants', 'product_variants.variant_id', '=', 'variants.id')
                ->select('variants.name', 'product_variants.item_code', 'product_variants.additional_cost', 'product_variants.additional_price', 'product_variants.qty')
                ->orderBy('product_variants.position')
                ->where('product_id', $id)
                ->get();
        }
    }

    public function edit($id)
    {
        $role = Role::firstOrCreate(['id' => Auth::user()->role_id]);
        if ($role->hasPermissionTo('products-edit')) {
            $lims_product_list_without_variant = $this->productWithoutVariant();
            $lims_product_list_with_variant = $this->productWithVariant();
            $lims_brand_list = Brand::where('is_active', true)->get();
            $lims_category_list = Category::where('is_active', true)->get();
            $lims_unit_list = Unit::where('is_active', true)->get();
            $lims_tax_list = Tax::where('is_active', true)->get();
            $lims_product_data = Product::where('id', $id)->first();
            if ($lims_product_data->variant_option) {
                $lims_product_data->variant_option = json_decode($lims_product_data->variant_option);
                $lims_product_data->variant_value = json_decode($lims_product_data->variant_value);
            }
            $lims_product_variant_data = $lims_product_data->variant()->orderBy('position')->get();
            $lims_warehouse_list = Warehouse::where('is_active', true)->get();
            $noOfVariantValue = 0;
            $custom_fields = CustomField::where('belongs_to', 'product')->get();

            if (in_array('ecommerce', explode(',', config('addons')))) {
                $product_arr = explode(',', $lims_product_data->related_products);
                $related_products = DB::table('products')->whereIn('id', $product_arr)->get();
                return view('backend.product.edit', compact('related_products', 'lims_product_list_without_variant', 'lims_product_list_with_variant', 'lims_brand_list', 'lims_category_list', 'lims_unit_list', 'lims_tax_list', 'lims_product_data', 'lims_product_variant_data', 'lims_warehouse_list', 'noOfVariantValue', 'custom_fields'));
            }
            return view('backend.product.edit', compact('lims_product_list_without_variant', 'lims_product_list_with_variant', 'lims_brand_list', 'lims_category_list', 'lims_unit_list', 'lims_tax_list', 'lims_product_data', 'lims_product_variant_data', 'lims_warehouse_list', 'noOfVariantValue', 'custom_fields'));
        } else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function updateProduct(Request $request)
    {
        try {
            $this->validate($request, [
                'name' => [
                    'max:255',
                    Rule::unique('products')->ignore($request->input('id'))->where(function ($query) {
                        return $query->where('is_active', 1);
                    }),
                ],

                'code' => [
                    'max:255',
                    Rule::unique('products')->ignore($request->input('id'))->where(function ($query) {
                        return $query->where('is_active', 1);
                    }),
                ]
            ]);

            $lims_product_data = Product::findOrFail($request->input('id'));
            $data = $request->except('image', 'file', 'prev_img');
            $data['name'] = htmlspecialchars(trim($data['name']), ENT_QUOTES);

            if (array_key_exists('product_details', $data)) {
                $data['product_details'] = str_replace('"', '@', $data['product_details']);
            }

            $data['expire_date'] = $request->expire_date;

            $lims_product_data->update($data);

            $initial_stock = 0;
            if (isset($data['stock_warehouse_id'])) {
                foreach ($data['stock_warehouse_id'] as $key => $warehouse_id) {
                    $stock = $data['stock'][$key];
                    $productWarehouseData = Product_Warehouse::where('product_id', $lims_product_data->id)->where('warehouse_id', $warehouse_id)->first();

                    if ($productWarehouseData) {
                        $productWarehouseData->qty = $stock;
                        $initial_stock = $stock;
                        $productWarehouseData->update();
                    }
                }
            }
            if ($initial_stock >= 0) {
                $lims_product_data->qty = $initial_stock;
                $lims_product_data->save();
            }

            $this->cacheForget('product_list');
            $this->cacheForget('product_list_with_variant');
            \Session::flash('edit_message', 'Product updated successfully');
        } catch (Exception $e) {
            \Log::error($e->getMessage());
            return response()->json(['error' => 'Internal server error'], 500);
        }
    }

    public function generateCode()
    {
        $id = Keygen::numeric(8)->generate();
        return $id;
    }

    public function search(Request $request)
    {
        $product_code = explode(" (", $request['data']);
        $lims_product_data = Product::where('code', $product_code[0])->first();

        $product[] = $lims_product_data->name;
        $product[] = $lims_product_data->code;
        $product[] = $lims_product_data->qty;
        $product[] = $lims_product_data->price;
        $product[] = $lims_product_data->id;
        return $product;
    }

    public function saleUnit($id)
    {
        $unit = Unit::where("base_unit", $id)->orWhere('id', $id)->pluck('unit_name', 'id');
        return json_encode($unit);
    }

    public function getData($id, $variant_id)
    {
        if ($variant_id) {
            $data = Product::join('product_variants', 'products.id', 'product_variants.product_id')
                ->select('products.name', 'product_variants.item_code')
                ->where([
                    ['products.id', $id],
                    ['product_variants.variant_id', $variant_id]
                ])->first();
            $data->code = $data->item_code;
        } else
            $data = Product::select('name', 'code')->find($id);
        return $data;
    }

    public function productWarehouseData($id)
    {
        $warehouse = [];
        $qty = [];
        $batch = [];
        $expired_date = [];
        $imei_number = [];
        $warehouse_name = [];
        $variant_name = [];
        $variant_qty = [];
        $product_warehouse = [];
        $product_variant_warehouse = [];
        $lims_product_data = Product::select('id', 'is_variant')->find($id);
        if ($lims_product_data->is_variant) {
            $lims_product_variant_warehouse_data = Product_Warehouse::where('product_id', $lims_product_data->id)->orderBy('warehouse_id')->get();
            $lims_product_warehouse_data = Product_Warehouse::select('warehouse_id', DB::raw('sum(qty) as qty'))->where('product_id', $id)->groupBy('warehouse_id')->get();
            foreach ($lims_product_variant_warehouse_data as $key => $product_variant_warehouse_data) {
                $lims_warehouse_data = Warehouse::find($product_variant_warehouse_data->warehouse_id);
                $lims_variant_data = Variant::find($product_variant_warehouse_data->variant_id);
                $warehouse_name[] = $lims_warehouse_data->name;
                $variant_name[] = $lims_variant_data->name;
                $variant_qty[] = $product_variant_warehouse_data->qty;
            }
        } else {
            $lims_product_warehouse_data = Product_Warehouse::where('product_id', $id)->orderBy('warehouse_id', 'asc')->get();
        }
        foreach ($lims_product_warehouse_data as $key => $product_warehouse_data) {
            $lims_warehouse_data = Warehouse::find($product_warehouse_data->warehouse_id);
            if ($product_warehouse_data->product_batch_id) {
                $product_batch_data = ProductBatch::select('batch_no', 'expired_date')->find($product_warehouse_data->product_batch_id);
                $batch_no = $product_batch_data->batch_no;
                $expiredDate = date(config('date_format'), strtotime($product_batch_data->expired_date));
            } else {
                $batch_no = 'N/A';
                $expiredDate = 'N/A';
            }
            $warehouse[] = $lims_warehouse_data->name;
            $batch[] = $batch_no;
            $expired_date[] = $expiredDate;
            $qty[] = $product_warehouse_data->qty;
            if ($product_warehouse_data->imei_number && !str_contains($product_warehouse_data->imei_number, 'null'))
                $imei_number[] = $product_warehouse_data->imei_number;
            else
                $imei_number[] = 'N/A';
        }

        $product_warehouse = [$warehouse, $qty, $batch, $expired_date, $imei_number];
        $product_variant_warehouse = [$warehouse_name, $variant_name, $variant_qty];
        return ['product_warehouse' => $product_warehouse, 'product_variant_warehouse' => $product_variant_warehouse];
    }

    public function printBarcode(Request $request)
    {
        //return $request;
        if ($request->input('data')) {
            $preLoadedproducts = $this->limsProductSearch($request);
            //return $this->limsProductSearch($request);
        } else
            $preLoadedproducts = [];

        $lims_product_list_without_variant = $this->productWithoutVariant();
        $lims_product_list_with_variant = $this->productWithVariant();

        $barcode_settings = Barcode::select(DB::raw('CONCAT(name, ", ", COALESCE(description, "")) as name, id, is_default'))->get();
        $default = $barcode_settings->where('is_default', 1)->first();
        $barcode_settings = $barcode_settings->pluck('name', 'id');

        return view('backend.product.print_barcode', compact('barcode_settings', 'lims_product_list_without_variant', 'lims_product_list_with_variant', 'preLoadedproducts'));
    }

    public function productWithoutVariant()
    {
        return Product::ActiveStandard()->select('id', 'name', 'code')
            ->whereNull('is_variant')->get();
    }

    public function productWithVariant()
    {
        return Product::join('product_variants', 'products.id', 'product_variants.product_id')
            ->ActiveStandard()
            ->whereNotNull('is_variant')
            ->select('products.id', 'products.name', 'product_variants.item_code')
            ->orderBy('position')->get();
    }

    public function limsProductSearch(Request $request)
    {
        $product_code = explode("(", $request['data']);
        $product_code[0] = rtrim($product_code[0], " ");
        $lims_product_list = Product::where([
            ['code', $product_code[0]],
            ['is_active', true]
        ])->get();

        if (count($lims_product_list) == 0) {
            $lims_product_list = Product::join('product_variants', 'products.id', 'product_variants.product_id')
                ->select('products.*', 'product_variants.item_code', 'product_variants.variant_id', 'product_variants.additional_price')
                ->where('product_variants.item_code', $product_code[0])
                ->get();
        } elseif ($lims_product_list[0]->is_variant) {
            $lims_product_list = Product::join('product_variants', 'products.id', 'product_variants.product_id')
                ->select('products.*', 'product_variants.item_code', 'product_variants.variant_id', 'product_variants.additional_price')
                ->where('product_variants.product_id', $lims_product_list[0]->id)
                ->get();
        }
        //return $lims_product_list;
        foreach ($lims_product_list as $lims_product_data) {
            $product = [];
            $product[] = $lims_product_data->name;
            if ($lims_product_data->is_variant) {
                $product[] = $lims_product_data->item_code;
                $variant_id = $lims_product_data->variant_id;
                $additional_price = $lims_product_data->additional_price;
            } else {
                $product[] = $lims_product_data->code;
                $variant_id = '';
                $additional_price = 0;
            }

            $product[] = $lims_product_data->price + $additional_price;
            $product[] = DNS1D::getBarcodePNG($product[1], $lims_product_data->barcode_symbology);
            $product[] = $lims_product_data->promotion_price;
            $product[] = config('currency');
            $product[] = config('currency_position');
            $product[] = $lims_product_data->qty;
            $product[] = $lims_product_data->id;
            $product[] = $variant_id;
            $product[] = $lims_product_data->cost;
            $products[] = $product;
        }
        return $products;
    }

    public function checkBatchAvailability($product_id, $batch_no, $warehouse_id)
    {
        $product_batch_data = ProductBatch::where([
            ['product_id', $product_id],
            ['batch_no', $batch_no]
        ])->first();
        if ($product_batch_data) {
            $product_warehouse_data = Product_Warehouse::select('qty')
                ->where([
                    ['product_batch_id', $product_batch_data->id],
                    ['warehouse_id', $warehouse_id]
                ])->first();
            if ($product_warehouse_data) {
                $data['qty'] = $product_warehouse_data->qty;
                $data['product_batch_id'] = $product_batch_data->id;
                $data['expired_date'] = date(config('date_format'), strtotime($product_batch_data->expired_date));
                $data['message'] = 'ok';
            } else {
                $data['qty'] = 0;
                $data['message'] = 'This Batch does not exist in the selected warehouse!';
            }
        } else {
            $data['message'] = 'Wrong Batch Number!';
        }
        return $data;
    }

    public function importProduct(Request $request)
    {
        ini_set('memory_limit', '8000M');
        ini_set('max_execution_time', '1222222222222');
        // Get file
        $upload = $request->file('file');
        $ext = pathinfo($upload->getClientOriginalName(), PATHINFO_EXTENSION);
        if ($ext != 'csv') {
            return redirect()->back()->with('message', 'Please upload a valid CSV file.');
        }

        $filePath = $upload->getRealPath();

        // Open and read file
        $file = fopen($filePath, 'r');
        $header = fgetcsv($file);
        if (!$header) {
            fclose($file);
            return redirect()->back()->with('message', 'CSV file is empty or invalid.');
        }

        $escapedHeader = [];
        foreach ($header as $key => $value) {
            $lheader = strtolower(trim($value));
            $escapedItem = preg_replace('/[^a-z]/', '', $lheader);
            $escapedHeader[] = $escapedItem;
        }

        // Looping through other columns
        try {
            while ($columns = fgetcsv($file)) {
                if (count($escapedHeader) !== count($columns)) {
                    fclose($file);
                    return redirect()->back()->with('message', 'CSV file format is incorrect.');
                }

                $data = array_combine($escapedHeader, $columns);

                // Validate and sanitize input
                $data['name'] = htmlspecialchars(trim($data['name']));
                $data['cost'] = is_numeric($data['cost']) ? str_replace(",", "", $data['cost']) : 0;
                $data['price'] = is_numeric($data['price']) ? str_replace(",", "", $data['price']) : 0;
                // $data['alert_quantity'] = is_numeric($data['alert_quantity']) ? str_replace(",", "", $data['alert_quantity']) : 0;
                // Handle brand
                $brand_id = null;
                if (isset($data['brand']) && $data['brand'] !== 'N/A' && $data['brand'] !== '') {
                    $lims_brand_data = Brand::firstOrCreate(['title' => $data['brand'], 'is_active' => true]);
                    $brand_id = $lims_brand_data->id;
                }

                // Handle category
                $lims_category_data = Category::firstOrCreate(['name' => $data['category'], 'is_active' => true]);

                // Handle unit
                $lims_unit_data = Unit::where('unit_code', $data['unitcode'])->first();
                if (!$lims_unit_data) {
                    fclose($file);
                    return redirect()->back()->with('not_permitted', 'Unit code does not exist in the database.');
                }

                // Create or update product
                $product = Product::firstOrNew([
                    'name' => $data['name'],
                    'is_active' => true
                ]);

                $product->fill([
                    'code'          => $data['code'],
                    'type'          => strtolower($data['type']),
                    'barcode_symbology' => 'C128',
                    'brand_id'      => $brand_id,
                    'category_id'   => $lims_category_data->id,
                    'unit_id'       => $lims_unit_data->id,
                    'purchase_unit_id' => $lims_unit_data->id,
                    'sale_unit_id'  => $lims_unit_data->id,
                    'cost'          => $data['cost'],
                    'price'         => $data['price'],
                    'tax_method'    => 1,
                    'qty'           => 0,
                    'product_details' => $data['productdetails'] ?? '',
                    'is_active'     => true,
                    'alert_quantity' => $data['alertquantity'] ?? 0,
                    'expire_date'   => date("Y-m-d", strtotime("2999-12-31")),
                    'image'         => '',
                ]);

                if (in_array('ecommerce', explode(',', config('addons')))) {
                    $data['slug'] = Str::slug($data['name'], '-');
                    $product->slug = preg_replace('/[^A-Za-z0-9\-]/', '', $data['slug']);
                    $product->in_stock = true;
                }

                $product->save();

                // Handle variants
                $warehouse_ids = Warehouse::where('is_active', true)->pluck('id');

                Product_Warehouse::insert([
                    'product_id' => $product->id,
                    'warehouse_id' => 1,
                    'qty' => 0,
                ]);
            }

            fclose($file);
            $this->cacheForget('product_list');
            $this->cacheForget('product_list_with_variant');
            return redirect('products')->with('import_message', 'Products imported successfully!');
        } catch (\Exception $e) {
            \Log::error($e->getMessage());
            fclose($file);
            return redirect()->back()->with('message', 'Error: ' . $e->getMessage());
        }
    }

    // UPDATE PRODUCTS IN BULK USING CSV
    public function bulkUpdateproduct1(Request $request)
    {
        ini_set('memory_limit', '8000M');
        ini_set('max_execution_time', '1222222222222');
        $upload = $request->file('file');
        $ext = pathinfo($upload->getClientOriginalName(), PATHINFO_EXTENSION);
        if ($ext != 'csv') {
            return redirect()->back()->with('message', 'Please upload a valid CSV file.');
        }

        $filePath = $upload->getRealPath();

        // Open and read file
        $file = fopen($filePath, 'r');
        $header = fgetcsv($file);
        if (!$header) {
            fclose($file);
            return redirect()->back()->with('message', 'CSV file is empty or invalid.');
        }

        $escapedHeader = [];
        foreach ($header as $key => $value) {
            $lheader = strtolower(trim($value));
            $escapedItem = preg_replace('/[^a-z]/', '', $lheader);
            $escapedHeader[] = $escapedItem;
        }

        // Looping through other columns
        try {
            while ($columns = fgetcsv($file)) {
                if (count($escapedHeader) !== count($columns)) {
                    fclose($file);
                    return redirect()->back()->with('message', 'CSV file format is incorrect.');
                }

                $data = array_combine($escapedHeader, $columns);

                $data['name'] = htmlspecialchars(trim($data['name']));
                $data['cost'] = is_numeric($data['cost']) ? str_replace(",", "", $data['cost']) : 0;
                $data['price'] = is_numeric($data['price']) ? str_replace(",", "", $data['price']) : 0;
                // $data['alert_quantity'] = is_numeric($data['alert_quantity']) ? str_replace(",", "", $data['alert_quantity']) : 0;

                $brand_id = null;
                if (isset($data['brand']) && $data['brand'] !== 'N/A' && $data['brand'] !== '') {
                    $lims_brand_data = Brand::firstOrCreate(['title' => $data['brand'], 'is_active' => true]);
                    $brand_id = $lims_brand_data->id;
                }

                // Handle category
                $lims_category_data = Category::firstOrCreate(['name' => $data['category'], 'is_active' => true]);

                // Handle unit
                $lims_unit_data = Unit::where('unit_code', $data['unitcode'])->first();
                if (!$lims_unit_data) {
                    fclose($file);
                    return redirect()->back()->with('not_permitted', 'Unit code does not exist in the database.');
                }

                $product = Product::firstOrNew([
                    'code' => $data['code'],
                    'is_active' => true
                ]);

                $product->update([
                    'name'          => $data['name'],
                    'brand_id'      => $brand_id,
                    'category_id'   => $lims_category_data->id,
                    'unit_id'       => $lims_unit_data->id,
                    'purchase_unit_id' => $lims_unit_data->id,
                    'sale_unit_id'  => $lims_unit_data->id,
                    'cost'          => $data['cost'],
                    'price'         => $data['price'],
                    'qty'           => $data['quantity'],
                    'alert_quantity' => $data['alertquantity'] ?? 0,
                    'is_active'     => true,
                    'expire_date' => !empty($data['expiredate']) ? date("Y-m-d", strtotime($data['expiredate'])) : null,
                ]);

                if (in_array('ecommerce', explode(',', config('addons')))) {
                    $data['slug'] = Str::slug($data['name'], '-');
                    $product->slug = preg_replace('/[^A-Za-z0-9\-]/', '', $data['slug']);
                    $product->in_stock = true;
                }

                $product->update();

                $warehouse_id = Warehouse::where('is_active', true)->pluck('id')->first(); // Get the first active warehouse ID

                if ($warehouse_id && isset($data['quantity'])) {
                    Product_Warehouse::where('product_id', $product->id)
                        ->where('warehouse_id', $warehouse_id)
                        ->update([
                            'qty' => $data['quantity'],
                            'updated_at' => now(),
                        ]);
                }
            }

            fclose($file);
            $this->cacheForget('product_list');
            $this->cacheForget('product_list_with_variant');
            return redirect('products')->with('import_message', 'Products imported successfully!');
        } catch (\Exception $e) {
            \Log::error($e->getMessage());
            fclose($file);
            return redirect()->back()->with('message', 'Error: ' . $e->getMessage());
        }
    }


    public function bulkUpdateproduct_olds(Request $request)
    {
        ini_set('memory_limit', '8192M');
        ini_set('max_execution_time', '0');

        $upload = $request->file('file');
        $ext = pathinfo($upload->getClientOriginalName(), PATHINFO_EXTENSION);
        if ($ext != 'csv') {
            return redirect()->back()->with('message', 'Please upload a valid CSV file.');
        }

        $filePath = $upload->getRealPath();
        $file = fopen($filePath, 'r');
        $header = fgetcsv($file);
        if (!$header) {
            fclose($file);
            return redirect()->back()->with('message', 'CSV file is empty or invalid.');
        }

        $escapedHeader = array_map(function ($col) {
            return preg_replace('/[^a-z]/', '', strtolower(trim($col)));
        }, $header);

        $batch = [];
        $batchSize = 1000;

        try {
            DB::beginTransaction();

            while ($columns = fgetcsv($file)) {
                if (count($escapedHeader) !== count($columns)) {
                    continue;
                }

                $data = array_combine($escapedHeader, $columns);
                $data['name'] = htmlspecialchars(trim($data['name']));
                $data['cost'] = is_numeric($data['cost']) ? str_replace(",", "", $data['cost']) : 0;
                $data['price'] = is_numeric($data['price']) ? str_replace(",", "", $data['price']) : 0;

                $brand_id = null;
                if (!empty($data['brand']) && $data['brand'] !== 'N/A') {
                    $brand = Brand::firstOrCreate(['title' => $data['brand']], ['is_active' => true]);
                    $brand_id = $brand->id;
                }

                $category = Category::firstOrCreate(['name' => $data['category']], ['is_active' => true]);

                $unit = Unit::where('unit_code', $data['unitcode'])->first();
                if (!$unit) continue;

                $product = Product::updateOrCreate(
                    ['code' => $data['code']],
                    [
                        'name'            => $data['name'],
                        'brand_id'        => $brand_id,
                        'category_id'     => $category->id,
                        'unit_id'         => $unit->id,
                        'purchase_unit_id' => $unit->id,
                        'sale_unit_id'    => $unit->id,
                        'cost'            => $data['cost'],
                        'price'           => $data['price'],
                        'qty'             => $data['quantity'],
                        'alert_quantity'  => $data['alertquantity'] ?? 0,
                        'expire_date'     => !empty($data['expiredate']) ? date("Y-m-d", strtotime($data['expiredate'])) : null,
                        'is_active'       => true
                    ]
                );

                if (in_array('ecommerce', explode(',', config('addons')))) {
                    $product->slug = preg_replace('/[^A-Za-z0-9\-]/', '', Str::slug($data['name']));
                    $product->in_stock = true;
                    $product->save();
                }

                $warehouse_id = Warehouse::where('is_active', true)->value('id');
                if ($warehouse_id && isset($data['quantity'])) {
                    Product_Warehouse::updateOrCreate(
                        ['product_id' => $product->id, 'warehouse_id' => $warehouse_id],
                        ['qty' => $data['quantity'], 'updated_at' => now()]
                    );
                }
            }

            fclose($file);
            DB::commit();

            $this->cacheForget('product_list');
            $this->cacheForget('product_list_with_variant');

            return redirect('products')->with('import_message', 'Products imported successfully!');
        } catch (\Exception $e) {
            DB::rollBack();
            fclose($file);
            \Log::error($e->getMessage());
            return redirect()->back()->with('message', 'Error: ' . $e->getMessage());
        }
    }

    public function bulkUpdateproduct(Request $request)
    {
        ini_set('memory_limit', '8192M');
        ini_set('max_execution_time', '0');

        $upload = $request->file('file');
        $ext = pathinfo($upload->getClientOriginalName(), PATHINFO_EXTENSION);
        if ($ext != 'csv') {
            return redirect()->back()->with('message', 'Please upload a valid CSV file.');
        }

        $filePath = $upload->getRealPath();
        $file = fopen($filePath, 'r');
        $header = fgetcsv($file);
        if (!$header) {
            fclose($file);
            return redirect()->back()->with('message', 'CSV file is empty or invalid.');
        }

        $escapedHeader = array_map(function ($col) {
            return preg_replace('/[^a-z]/', '', strtolower(trim($col)));
        }, $header);

        try {
            DB::beginTransaction();

            while ($columns = fgetcsv($file)) {
                if (count($escapedHeader) !== count($columns)) {
                    continue;
                }

                $data = array_combine($escapedHeader, $columns);
                $data['code'] = trim($data['code']);
                $product = Product::where('code', $data['code'])->first();

                // Skip if product not found (no insertion will be done)
                if (!$product) continue;

                // Update only the fields provided in CSV
                if (!empty($data['name'])) {
                    $product->name = htmlspecialchars(trim($data['name']));
                    if (in_array('ecommerce', explode(',', config('addons')))) {
                        $product->slug = preg_replace('/[^A-Za-z0-9\-]/', '', Str::slug($data['name']));
                    }
                }

                if (!empty($data['brand']) && $data['brand'] !== 'N/A') {
                    $brand = Brand::firstOrCreate(['title' => $data['brand']], ['is_active' => true]);
                    $product->brand_id = $brand->id;
                }

                if (!empty($data['category'])) {
                    $category = Category::firstOrCreate(['name' => $data['category']], ['is_active' => true]);
                    $product->category_id = $category->id;
                }

                if (!empty($data['unitcode'])) {
                    $unit = Unit::where('unit_code', $data['unitcode'])->first();
                    if ($unit) {
                        $product->unit_id = $unit->id;
                        $product->purchase_unit_id = $unit->id;
                        $product->sale_unit_id = $unit->id;
                    }
                }

                if (!empty($data['cost']) && isset($data['cost']) && is_numeric($data['cost'])) {
                    $product->cost = str_replace(",", "", $data['cost']);
                }

                if (!empty($data['price']) && isset($data['price']) && is_numeric($data['price'])) {
                    $product->price = str_replace(",", "", $data['price']);
                }
                if (!empty($data['quantity']) && isset($data['quantity'])) {
                    $product->qty = $data['quantity'];
                }
                if (!empty($data['alertquantity']) && isset($data['alertquantity'])) {
                    $product->alert_quantity = $data['alertquantity'];
                }

                if (!empty($data['expiredate'])) {
                    $product->expire_date = date("Y-m-d", strtotime($data['expiredate']));
                }

                $product->is_active = true;
                $product->save();

                // Update warehouse quantity if exists
                $warehouse_id = Warehouse::where('is_active', true)->value('id');
                if ($warehouse_id && isset($data['quantity'])) {
                    Product_Warehouse::updateOrCreate(
                        ['product_id' => $product->id, 'warehouse_id' => $warehouse_id],
                        ['qty' => $data['quantity'], 'updated_at' => now()]
                    );
                }
            }

            fclose($file);
            DB::commit();

            $this->cacheForget('product_list');
            $this->cacheForget('product_list_with_variant');

            return redirect('products')->with('import_message', 'Products updated successfully!');
        } catch (\Exception $e) {
            DB::rollBack();
            fclose($file);
            \Log::error($e->getMessage());
            return redirect()->back()->with('message', 'Error: ' . $e->getMessage());
        }
    }



    // DOWNLOAD ALL PRODUCT LISTING IN CSV
    public function downloadBulkProducts(Request $request)
    {
        try {
            ini_set('memory_limit', '1G');

            $products = Product::with('brand', 'category')
                ->whereNotNull('products.price')
                ->where('products.price', '!=', 0)
                ->where('products.is_active', true)
                // ->where('code',22479)
                ->get();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            $sheet->setCellValue('A1', 'name');
            $sheet->setCellValue('B1', 'code');
            $sheet->setCellValue('C1', 'brand');
            $sheet->setCellValue('D1', 'category');
            $sheet->setCellValue('E1', 'unitcode');
            $sheet->setCellValue('F1', 'cost');
            $sheet->setCellValue('G1', 'price');
            $sheet->setCellValue('H1', 'quantity');
            $sheet->setCellValue('I1', 'expire_date');
            $sheet->setCellValue('J1', 'profit_per_piece');
            $sheet->setCellValue('K1', 'expected_total_profit');
            $sheet->setCellValue('L1', 'alert_quantity');


            $row = 2;

            foreach ($products as $product) {
                $totalQuantity = Product_Warehouse::where('product_id', $product->id)->whereDate('updated_at', '!=', '2025-07-08')->sum('qty');
                // $totalQuantity = Product_Warehouse::where('product_id', $product->id)->where('updated_at','2025-07-08')->sum('qty');
                // dd( $totalQuantity);

                $qty = $product->quantity > $totalQuantity ? $product->quantity : $totalQuantity;

                $sheet->setCellValue('A' . $row, $product->name);
                $sheet->setCellValue('B' . $row, $product->code);
                $sheet->setCellValue('C' . $row, $product->brand ? $product->brand->title : 'N/A');
                $sheet->setCellValue('D' . $row, $product->category ? $product->category->name : 'N/A');
                $sheet->setCellValue('E' . $row, $product->unit->unit_code);
                $sheet->setCellValue('F' . $row, $product->cost);
                $sheet->setCellValue('G' . $row, $product->price);
                $sheet->setCellValue('H' . $row, $qty);
                $sheet->setCellValue('I' . $row, $product->expiry_date ? $product->expiry_date->format('Y-m-d') : '');
                $sheet->setCellValue('J' . $row, $product->price && $product->cost ? $product->price - $product->cost : 0);
                $sheet->setCellValue('K' . $row, $product->price && $product->cost && $qty > 0 ? ($product->price - $product->cost) * $qty : 0);
                $sheet->setCellValue('L' . $row, $product->alert_quantity ?? 0);

                $row++;
            }

            // $filename = 'bulk_products_export.xlsx';
            $filename = 'ACTIVE PRODUCT LISTING - ' . date('d-m-Y H:i') . '.csv';

            // $writer = new Xlsx($spreadsheet); // For Excel format
            $writer = new Csv($spreadsheet); // For CSV format

            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header('Content-Disposition: attachment;filename="' . $filename . '"');
            header('Cache-Control: max-age=0');

            $writer->save('php://output');
        } catch (\Exception $e) {
            return redirect()->back()->with('message', 'Error: ' . $e->getMessage());
        }
    }


    public function downloadBulkProducts_old(Request $request)
    {
        try {
            ini_set('memory_limit', '1G');
            set_time_limit(300); // Long process
            //  with('brand', 'category')
            // Get products with total quantity from warehouse in one query using JOIN + GROUP
            // $products = Product::with('brand', 'category')
            //     ->leftJoin('product_warehouse', 'products.id', '=', 'product_warehouse.product_id')
            // ->select(
            //     'products.id',
            //     'products.name',
            //     'products.code',
            //     'products.unit_id',
            //     'products.cost',
            //     'products.price',
            //     'products.qty as quantity',
            //     'products.expire_date as expiry_date',
            //     DB::raw('COALESCE(SUM(product_warehouse.qty), 0) as total_qty')
            // )
            // ->whereNotNull('products.price')
            // ->where('products.price', '!=', 0)
            // ->where('products.is_active', true)
            //     ->groupBy('products.id')
            //     ->withCasts(['expiry_date' => 'datetime:Y-m-d'])
            //     ->get();
            $products = Product::leftJoin('product_warehouse', 'products.id', '=', 'product_warehouse.product_id')
                ->select(
                    'products.id',
                    'products.name',
                    'products.code',
                    'products.unit_id',
                    'products.cost',
                    'products.price',
                    'products.qty as quantity',
                    'products.expire_date as expiry_date',
                    DB::raw('COALESCE(SUM(product_warehouse.qty), 0) as total_qty')
                )

                ->whereNotNull('products.price')
                ->where('products.price', '!=', 0)
                ->where('products.is_active', true)
                ->groupBy('products.id')
                ->with('brand', 'category')
                ->get();

            // Initialize spreadsheet
            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            $headers = ['name', 'code', 'brand', 'category', 'unitcode', 'cost', 'price', 'quantity', 'expire_date', 'profit_per_piece', 'expected_total_profit'];

            // Set headers
            foreach ($headers as $index => $header) {
                $sheet->setCellValueByColumnAndRow($index + 1, 1, $header);
            }
            // Set rows
            $row = 2;
            foreach ($products as $product) {
                $qty = max($product->quantity, $product->total_qty);
                $profitPerPiece = $product->price && $product->cost ? $product->price - $product->cost : 0;
                $expectedProfit = $qty > 0 ? $profitPerPiece * $qty : 0;

                $sheet->fromArray([
                    $product->name,
                    $product->code,
                    $product->brand->title ?? 'N/A',
                    $product->category->name ?? 'N/A',
                    $product->unit->unit_code ?? 'N/A',
                    $product->cost,
                    $product->price,
                    $qty,
                    $product->expiry_date ? $product->expiry_date->format('Y-m-d') : '',
                    $profitPerPiece,
                    $expectedProfit
                ], null, 'A' . $row);

                $row++;
            }

            // Filename
            $filename = 'ACTIVE PRODUCT LISTING - ' . now()->format('d-m-Y H:i') . '.csv';

            // Writer
            $writer = new Csv($spreadsheet);
            $writer->setDelimiter(',');
            $writer->setEnclosure('"');
            $writer->setSheetIndex(0);

            // Output
            header('Content-Type: text/csv');
            header("Content-Disposition: attachment;filename=\"$filename\"");
            header('Cache-Control: max-age=0');

            $writer->save('php://output');
            exit;
        } catch (\Exception $e) {
            return redirect()->back()->with('message', 'Error: ' . $e->getMessage());
        }
    }


    public function allProductInStock()
    {
        if (!in_array('ecommerce', explode(',', config('addons'))))
            return redirect()->back()->with('not_permitted', 'Please install the ecommerce addon!');
        Product::where('is_active', true)->update(['in_stock' => true]);
        return redirect()->back()->with('create_message', 'All Products set to in stock successfully!');
    }

    public function showAllProductOnline()
    {
        if (!in_array('ecommerce', explode(',', config('addons'))))
            return redirect()->back()->with('not_permitted', 'Please install the ecommerce addon!');
        Product::where('is_active', true)->update(['is_online' => true]);
        return redirect()->back()->with('create_message', 'All Products will be showed to online!');
    }

    public function deleteBySelection(Request $request)
    {
        $product_id = $request['productIdArray'];
        foreach ($product_id as $id) {
            $lims_product_data = Product::findOrFail($id);
            $lims_product_data->is_active = false;
            $lims_product_data->save();

            if ($lims_product_data->image) {
                $images = explode(",", $lims_product_data->image);
                foreach ($images as $image) {
                    $this->fileDelete(public_path('images/product/'), $image);
                }
            }
        }
        $this->cacheForget('product_list');
        $this->cacheForget('product_list_with_variant');
        return 'Product deleted successfully!';
    }

    public function destroy($id)
    {
        // if(!env('USER_VERIFIED')) {
        //     return redirect()->back()->with('not_permitted', 'This feature is disable for demo!');
        // }
        // else {
        $lims_product_data = Product::findOrFail($id);
        $lims_product_data->is_active = false;
        if ($lims_product_data->image != 'zummXD2dvAtI.png') {
            $images = explode(",", $lims_product_data->image);
            foreach ($images as $key => $image) {
                $this->fileDelete(public_path('images/product/'), $image);
                $this->fileDelete(public_path('images/product/large/'), $image);
                $this->fileDelete(public_path('images/product/medium/'), $image);
                $this->fileDelete(public_path('images/product/small/'), $image);
            }
        }
        $lims_product_data->save();
        $this->cacheForget('product_list');
        $this->cacheForget('product_list_with_variant');
        return redirect('products')->with('message', 'Product deleted successfully');
        // }
    }
}
