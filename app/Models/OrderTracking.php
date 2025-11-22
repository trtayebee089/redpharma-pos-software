<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderTracking extends Model
{
    use HasFactory;

    protected $fillable = [
        'tracking_no',
        'sale_id',
        'current_status',
        'assigned_rider_id',
    ];

    public function sale()
    {
        return $this->belongsTo(Sale::class, 'sale_id');
    }

    public function rider()
    {
        return $this->belongsTo(Rider::class, 'assigned_rider_id');
    }

    public function histories()
    {
        return $this->hasMany(OrderTrackingHistory::class, 'tracking_id');
    }
}