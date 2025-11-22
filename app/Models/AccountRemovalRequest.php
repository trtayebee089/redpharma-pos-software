<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AccountRemovalRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'issue',
        'comment',
    ];

    public function user()
    {
        return $this->belongsTo(Customer::class, 'id', 'user_id');
    }
}
