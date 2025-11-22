<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rider extends Model
{
    use HasFactory;

    protected $fillable = [
        'full_name',
        'phone',
        'nid',
        'address',
        'emergency_contact',
        'completed_orders',
        'canceled_orders',
    ];

    protected $attributes = [
        'completed_orders' => 0,
        'canceled_orders' => 0,
    ];

    public function assignedOrders()
    {
        return $this->hasMany(\App\Models\OrderTracking::class, 'assigned_rider_id');
    }
}
