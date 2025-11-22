<?php

namespace App\Http\Controllers\Api;

use Exception;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Customer;
use Illuminate\Http\Request;
use App\Models\RewardPointTier;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        Log::info($request->all());
        $valdiator = Validator::make($request->all(), [
            'phone_number' => 'required|string|unique:customers,phone_number',
            'name'         => 'required|string|max:255',
            'email'        => 'required|string',
            'password'     => 'required|string|min:6|confirmed',
        ]);
        Log::info($valdiator->errors());

        if ($valdiator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $valdiator->errors(),
            ]);
        }

        $password = $request->password;

        $customer = Customer::create([
            'phone_number' => $request->phone_number,
            'email'        => $request->email,
            'name'         => $request->name,
            'address'      => $request->address,
            'gender'       => $request->gender ?? 'male',
            'password'     => Hash::make($request->password),
            'customer_group_id' => 1,
            'is_active'    => 1,
        ]);

        $token = $customer->createToken('auth_token')->plainTextToken;

        $customer = Customer::with(['customerGroup', 'discountPlans'])->find($customer->id);

        Log::info($customer->toArray());

        Mail::send('mail.registration_confirmation', [
            'phone_number' => $customer->phone_number,
            'password'     => $password,
        ], function ($message) use ($customer) {
            $message->to($customer->email)->subject('Welcome to Red Pharma BD');
        });

        return response()->json([
            'success' => true,
            'message' => 'Customer registered successfully',
            'data'    => [
                'user'  => $customer,
                'token' => $token,
            ],
        ]);
    }

    public function login(Request $request)
    {
        $request->validate([
            'phone_number' => 'required|string',
            'password'     => 'required|string',
        ]);

        $user = Customer::where('phone_number', $request->phone_number)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid phone number or password',
            ], 401);
        }

        // Load relations safely
        $user->load(['customerGroup', 'discountPlans']);

        // Create API token
        $token = $user->createToken('auth_token')->plainTextToken;
        $user->avatar = $user->avator;

        return response()->json([
            'success' => true,
            'message' => 'Login successful',
            'user'    => $user,
            'token'   => $token,
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logged out successfully',
        ]);
    }

    public function profile(Request $request)
    {
        $user = $request->user();
        $rewardTiers = RewardPointTier::all();
        $userPoints = $user->points ?? 0;

        $currentTier = $rewardTiers->first(function ($tier) use ($userPoints) {
            return $userPoints >= $tier->min_points && $userPoints <= $tier->max_points;
        });

        $orders = OrderController::orderlist($user);
        $data = [
            'success'       => true,
            'user'          => $user,
            'reward_tiers'  => $rewardTiers,
            'membership'    => $currentTier,
            'orders'        => $orders,
        ];
        return response()->json($data);
    }

    public function updateProfile(Request $request)
    {
        $customer = Customer::findOrFail($request->id);

        $validator = Validator::make($request->all(), [
            'name'         => 'required|string|max:255',
            'phone_number' => [
                'required',
                'string',
                Rule::unique('customers', 'phone_number')->ignore($customer->id, 'id'),
            ],
            'email'        => [
                'nullable',
                'email',
                Rule::unique('customers', 'email')->ignore($customer->id, 'id'),
            ],
            'gender'       => 'nullable|string|in:male,female,other',
            'address'      => 'nullable|string|max:1000',
            'avatar'       => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors(),
            ], 422);
        }

        // Handle avatar upload
        if ($request->hasFile('avatar')) {
            $file = $request->file('avatar');
            $destinationPath = public_path('avatars');

            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0755, true);
            }

            $filename = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move($destinationPath, $filename);

            if ($customer->avatar && file_exists(public_path($customer->avatar))) {
                unlink(public_path($customer->avatar));
            }

            $customer->avator = 'avatars/' . $filename;
        }

        // Update other fields
        $customer->fill($request->only([
            'name',
            'phone_number',
            'email',
            'age',
            'gender',
            'address',
        ]));

        $customer->save();

        return response()->json([
            'success' => true,
            'message' => 'Profile updated successfully',
            'data'    => $customer,
        ]);
    }

    public function updatePassword(Request $request)
    {
        $user = $request->user();

        $validator = Validator::make($request->all(), [
            'newPassword' => 'required|string|min:6|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        // Update password
        $user->password = Hash::make($request->newPassword);
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Password updated successfully'
        ]);
    }

    public function forgetPassword(Request $request)
    {
        $request->validate([
            'mobile' => 'required|string',
        ]);

        try {
            $customer = Customer::where('phone_number', $request->input('mobile'))->latest()->first();


            if (!$customer) {
                return response()->json([
                    'success' => false,
                    'message' => 'Customer Data Not Found'
                ], 404);
            }

            if (empty($customer->email)) {
                return response()->json([
                    'success' => false,
                    'message' => 'No email found for this customer'
                ], 400);
            }

            $token = mt_rand(100000, 999999);
            $email = $customer->email;

            DB::table('password_resets')->updateOrInsert(
                ['email' => $email],
                [
                    'token' => $token,
                    'created_at' => Carbon::now(),
                ]
            );


            Mail::send('mail.otp_code', ['token' => $token], function ($message) use ($email) {
                $message->to($email)
                    ->subject('Password Reset OTP');
            });

            return response()->json([
                'success' => true,
                'message' => 'OTP has been sent to your email'
            ]);
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Unexpected Error Occurred: ' . $e->getMessage()
            ], 500);
        }
    }

    public function verifyOTP(Request $request)
    {
        Log::info($request->all());
        $validator = Validator::make($request->all(), [
            'mobile' => 'required|string',
            'otp' => 'required|string',
            'password' => 'required|string|min:6|confirmed', // password_confirmation should be sent from client if using 'confirmed'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => $validator->errors()
            ]);
        }

        $mobile = $request->mobile;
        $otp = $request->otp;
        $newPassword = $request->password;

        $user = Customer::where('phone_number', $mobile)->first();
        if (!$user) {
            return response()->json(['message' => 'User not found.'], 404);
        }

        $reset = DB::table('password_resets')
            ->where('email', $user->email)
            ->where('token', $otp)
            ->first();

        if (!$reset) {
            return response()->json(['message' => 'Invalid OTP.'], 400);
        }

        if (Carbon::parse($reset->created_at)->addMinutes(15)->isPast()) {
            return response()->json(['message' => 'OTP has expired.'], 400);
        }

        $user->password = Hash::make($newPassword);
        $user->save();

        DB::table('password_resets')->where('email', $user->email)->delete();

        return response()->json(['success' => true, 'message' => 'Password has been reset successfully.'], 200);
    }
}
