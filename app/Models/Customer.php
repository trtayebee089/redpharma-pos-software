<?php

namespace App\Models;

use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Support\Facades\Log;

class Customer extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;
    
    protected $fillable =[
        "customer_group_id", "user_id", "name", "company_name", "avator",
        "email", "phone_number", "tax_no", "address", "city", "password",
        "state", "postal_code", "country", "points", "deposit", "expense", "wishlist", "is_active"
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    public function orders()
    {
        return $this->hasMany(Sale::class, 'customer_id', 'id')
                ->with(['products', 'tracking.histories']); 
    }

    public function customerGroup()
    {
        return $this->belongsTo('App\Models\CustomerGroup');
    }

    public function user()
    {
    	return $this->belongsTo('App\Models\User');
    }

    public function discountPlans()
    {
        return $this->belongsToMany('App\Models\DiscountPlan', 'discount_plan_customers');
    }

    public function getAvatorAttribute($value)
    {
        if ($value && file_exists(public_path($value))) {
            return asset($value);
        }

        return "https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small_2x/default-avatar-photo-placeholder-profile-icon-vector.jpg";
    }

    public function rewardPointUsages()
    {
        return $this->hasMany(RewardPointUsage::class, 'customer_id', 'id');
    }
}
