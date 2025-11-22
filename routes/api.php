<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\OrderController;

Route::options('{any}', function () {
    return response()->json([], 200);
})->where('any', '.*')->middleware('cors');

Route::middleware(['cors'])->group(function () {
    Route::post('/account-removal-request', [\App\Http\Controllers\Api\ServiceController::class, 'accountRemovalRequest']);
    
    Route::post('/checkout', [\App\Http\Controllers\Api\OrderController::class, 'store']);
    Route::get('/orders/{order_id}', [\App\Http\Controllers\Api\OrderController::class, 'getOrder']);
    Route::get('/tracking/{tracking_code}', [\App\Http\Controllers\Api\OrderController::class, 'getTrackingDetails']);
    Route::get('/reward-point-tiers', [\App\Http\Controllers\Api\ServiceController::class, 'getRewardPointTiers']);
    Route::get('/shipping-zones', [\App\Http\Controllers\Api\ServiceController::class, 'shippingZones']);
    Route::get('/search/{query}', [\App\Http\Controllers\Api\ProductController::class, 'search']);

    Route::prefix('customer')->group(function(){
        Route::post('/forget-password', [AuthController::class, 'forgetPassword']);
        Route::post('/verify-otp', [AuthController::class, 'verifyOTP']);
        Route::post('/register', [AuthController::class, 'register']);
        Route::post('/login', [AuthController::class, 'login']);
        Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
        Route::get('/profile', [AuthController::class, 'profile'])->middleware('auth:sanctum');
        Route::post('/profile/update', [AuthController::class, 'updateProfile'])->middleware('auth:sanctum');
        Route::post('/profile/update-password', [AuthController::class, 'updatePassword'])->middleware('auth:sanctum');
        Route::get('/orders', [OrderController::class, 'getOrders'])->middleware('auth:sanctum');
        Route::get('/orders/{order_id}', [OrderController::class, 'getOrderDetail'])->middleware('auth:sanctum');
    });    

    Route::prefix('categories')->group(function(){
        Route::get('/', [\App\Http\Controllers\Api\CategoryController::class, 'index']);
        Route::get('/boot-slug/update', [\App\Http\Controllers\Api\CategoryController::class, 'bootSlug']);
        Route::get('/{slug}', [\App\Http\Controllers\Api\CategoryController::class, 'show']);
    });

    Route::prefix('products')->group(function(){
        Route::get('/', [\App\Http\Controllers\Api\ProductController::class, 'index']);
        Route::get('/featured', [\App\Http\Controllers\Api\ProductController::class, 'featured']);
        Route::get('/best-selling', [\App\Http\Controllers\Api\ProductController::class, 'bestSelling']);
        Route::get('/boot-slug/update', [\App\Http\Controllers\Api\ProductController::class, 'bootSlug']);
        Route::get('/{slug}', [\App\Http\Controllers\Api\ProductController::class, 'show']);
    });
});
