<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderTrackingHistory extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'tracking_id',
        'status',
        'note',
        'created_at',
    ];

    public function tracking()
    {
        return $this->belongsTo(OrderTracking::class, 'tracking_id');
    }
}
