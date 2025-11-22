<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RewardPointUsage extends Model
{
    use HasFactory;

    protected $fillable = [
        'customer_id',
        'order_id',
        'tier_id',
        'points_used',
        'discount_amount',
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id', 'id');
    }

    public function order()
    {
        return $this->belongsTo(Sale::class, 'order_id', 'id');
    }

    public function tier()
    {
        return $this->belongsTo(RewardPointTier::class, 'tier_id', 'id');
    }
}
