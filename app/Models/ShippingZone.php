<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShippingZone extends Model
{
    use HasFactory;

    protected $fillable = [
        'division',
        'district',
        'thana',
        'rate',
        'estimated_delivery',
        'min_order_amount',
        'is_active',
        'notes',
    ];

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function getDisplayNameAttribute()
    {
        return collect([$this->thana, $this->district, $this->division])
            ->filter()
            ->join(', ');
    }
}
