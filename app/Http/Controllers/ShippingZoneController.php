<?php

namespace App\Http\Controllers;

use App\Models\ShippingZone;
use App\Services\SmsService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class ShippingZoneController extends Controller
{
    public function index()
    {
        return view('backend.setting.shipping_zones');
    }

    public function loadData(Request $request)
    {
        $query = ShippingZone::query();

        if ($request->has('search') && !empty($request->search['value'])) {
            $search = $request->search['value'];
            $query->where(function ($q) use ($search) {
                $q->where('division', 'like', "%{$search}%")
                    ->orWhere('district', 'like', "%{$search}%")
                    ->orWhere('thana', 'like', "%{$search}%");
            });
        }

        $totalData = $query->count();

        $start = $request->start ?? 0;
        $limit = $request->length ?? 10;
        $zones = $query->offset($start)
            ->limit($limit)
            ->orderBy('division')
            ->orderBy('district')
            ->orderBy('thana')
            ->get();

        $data = [];
        foreach ($zones as $zone) {
            $districtDisplay = $zone->district ?: '<em>All Districts</em>'; // Show "All Districts" if empty
            $rateDisplay = number_format($zone->rate, 2);

            $data[] = [
                'id' => $zone->id,
                'division' => $zone->division,
                'district' => $districtDisplay,
                'thana' => $zone->thana ?: '-',
                'rate' => $rateDisplay,
                'estimated_delivery' => $zone->estimated_delivery ?? '-',
                'delivery_partner' => $zone->delivery_partner ?? '-',
                'is_active' => $zone->is_active
                    ? '<span class="badge bg-success">Active</span>'
                    : '<span class="badge bg-danger">Inactive</span>',
                'actions' => '
                <button class="btn btn-sm btn-danger deleteZone" data-id="' . $zone->id . '"><i class="dripicons-trash"></i></button>
            '
            ];
        }

        return response()->json([
            "draw" => intval($request->draw),
            "recordsTotal" => $totalData,
            "recordsFiltered" => $totalData,
            "data" => $data
        ]);
    }


    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'division'           => 'required|string|max:255',
            'district'           => 'required|string|max:255', // district is required
            'default_rate'       => 'nullable|numeric|min:0',
            'thana'              => 'nullable|string|max:255',
            'apply_default_rate' => 'nullable|string|in:on,true,false',
            'estimated_delivery' => 'nullable|string|max:255',
            'is_active'          => 'nullable|string|in:on,true,false',
            'notes'              => 'nullable|string',
            'delivery_partner'   => 'nullable|string|in:rider,pathao,steadfast,sundarban,redx',
        ]);
        Log::info($request->all());

        if ($validator->fails()) {
            Log::info($validator->errors());
            return response()->json(['status' => false, 'errors' => $validator->errors()], 422);
        }

        $data = $validator->validated();
        $division = $data['division'];
        $district = $data['district'];
        $defaultRate = $data['default_rate'] ?? 0;
        $applyToAllThanas = $request->has('apply_default_rate');

        if ($applyToAllThanas) {
            ShippingZone::create([
                'division' => $division,
                'district' => $district,
                'rate' => $defaultRate,
                'estimated_delivery' => $data['estimated_delivery'] ?? null,
                'is_active' => $request->has('is_active') ? true : false,
                'notes' => $data['notes'] ?? null,
                'delivery_partner' => $data['delivery_partner'] ?? null,
            ]);
        }
        else {
            $thana = $data['thana'] ?? null;
            if (!$thana) {
                Log::info($validator->errors());
                return response()->json([
                    'status' => false,
                    'errors' => ['thana' => 'Please enter Thana / Police Station when not applying to all']
                ], 422);
            }

            ShippingZone::create([
                'division' => $division,
                'district' => $district,
                'thana' => $thana,
                'rate' => $defaultRate,
                'estimated_delivery' => $data['estimated_delivery'] ?? null,
                'is_active' => $request->has('is_active') ? true : false,
                'notes' => $data['notes'] ?? null,
                'delivery_partner' => $data['delivery_partner'] ?? null,
            ]);
        }

        return response()->json(['status' => true, 'message' => 'Shipping zone created successfully']);
    }


    public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required|exists:shipping_zones,id',
            'division' => 'required|string|max:255',
            'district' => 'nullable|string|max:255',
            'thana' => 'nullable|string|max:255',
            'rate' => 'required|numeric|min:0',
            'estimated_delivery' => 'nullable|string|max:255',
            'is_active' => 'boolean',
            'notes' => 'nullable|string'
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'errors' => $validator->errors()], 422);
        }

        $zone = ShippingZone::find($request->id);
        $zone->update($validator->validated());

        return response()->json(['status' => true, 'message' => 'Shipping zone updated successfully']);
    }

    public function delete(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required|exists:shipping_zones,id'
        ]);

        if ($validator->fails()) {
            Log::info($validator->errors());
            return response()->json(['status' => false, 'errors' => $validator->errors()], 422);
        }

        ShippingZone::find($request->id)->delete();

        return response()->json(['status' => true, 'message' => 'Shipping zone deleted successfully']);
    }
}
