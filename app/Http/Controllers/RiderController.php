<?php

namespace App\Http\Controllers;

use App\Models\Rider;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class RiderController extends Controller
{
    public function index(Request $request)
    {
        $role = Role::find(Auth::user()->role_id);

        if (!$role->hasPermissionTo('sales-index')) {
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
        }

        $permissions     = Role::findByName($role->name)->permissions;
        $all_permission  = $permissions->pluck('name')->toArray();
        if (empty($all_permission)) {
            $all_permission[] = 'dummy text';
        }
        $lims_user_list = Rider::orderBy('created_at', 'desc')->get();

        return view('backend.riders.index', compact(
            'lims_user_list',
            'all_permission',
        ));
    }

    public function tableLoader(Request $request)
    {
        $query = Rider::query();

        if ($search = $request->input('search')) {
            $query
                ->where('full_name', 'like', "%$search%")
                ->orWhere('phone', 'like', "%$search%")
                ->orWhere('nid', 'like', "%$search%");
        }

        $riders = $query->orderBy('created_at', 'desc')->paginate($request->input('per_page', 10));

        return response()->json($riders);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'full_name' => 'required|string|max:255',
            'phone'     => 'required|string|max:50|unique:riders,phone',
            'nid'       => 'nullable|string|max:100|unique:riders,nid',
            'address'   => 'nullable|string',
            'emergency_contact' => 'nullable|string|max:50',
        ]);

        if ($validator->fails()) {
            return response()->json(
                [
                    'success' => false,
                    'errors' => $validator->errors(),
                ],
                422,
            );
        }

        $rider = Rider::create($validator->validated());

        return response()->json([
            'success' => true,
            'data' => $rider,
            'message' => 'Rider created successfully.',
        ]);
    }

    public function update(Request $request, $id)
    {
        $rider = Rider::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'full_name' => 'required|string|max:255',
            'phone' => 'required|string|max:50|unique:riders,phone,' . $rider->id,
            'nid' => 'nullable|string|max:100|unique:riders,nid,' . $rider->id,
            'address' => 'nullable|string',
            'emergency_contact' => 'nullable|string|max:50',
            'completed_orders' => 'nullable|integer|min:0',
            'canceled_orders' => 'nullable|integer|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json(
                [
                    'success' => false,
                    'errors' => $validator->errors(),
                ],
                422,
            );
        }

        $rider->update($validator->validated());

        return response()->json([
            'success' => true,
            'data' => $rider,
            'message' => 'Rider updated successfully.',
        ]);
    }

    public function destroy($id)
    {
        $rider = Rider::findOrFail($id);

        $assignedOrdersCount = \App\Models\OrderTracking::where('assigned_rider_id', $rider->id)
            ->whereIn('current_status', ['pending', 'processing', 'in_transit', 'delivered'])
            ->count();

        if ($assignedOrdersCount > 0) {
            return response()->json(
                [
                    'success' => false,
                    'message' => 'Cannot delete rider. Rider is assigned to active orders.',
                ],
                400,
            );
        }

        $rider->delete();

        return response()->json([
            'success' => true,
            'message' => 'Rider deleted successfully.',
        ]);
    }
}
