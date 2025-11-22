<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RewardPointTier extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'min_points',
        'max_points',
        'discount_rate',
        'deduction_enabled', 'deduction_rate_per_unit', 'deduction_amount_unit',
        'color_code', 'color_class', 'icon_class',
    ];
}
