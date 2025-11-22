<?php

namespace App\Models;

use Illuminate\Support\Facades\Log;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $fillable = [
        "name",
        "slug",
        'image',
        "parent_id",
        "is_active",
        "is_sync_disable",
        "woocommerce_category_id",
        "slug",
        "featured",
        "page_title",
        "short_description"
    ];

    public function product()
    {
        return $this->hasMany('App\Models\Product');
    }

    public function parent()
    {
        return $this->belongsTo(Category::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(Category::class, 'parent_id');
    }

    public function getAllProductsAttribute()
    {
        $allProducts = $this->product()->get();

        foreach ($this->children as $child) {
            $allProducts = $allProducts->merge($child->product()->get());
        }

        return $allProducts;
    }

    public function getImageAttribute()
    {
        if (!empty($this->attributes['image'])) {
            return asset('images/category/' . $this->attributes['image']);
        }

        $parent = $this->parent;
        while ($parent) {
            if (!empty($parent->getRawOriginal('image'))) {
                return asset('images/category/' . $parent->getRawOriginal('image'));
            }
            $parent = $parent->parent;
        }

        return asset('images/no-image.png');
    }
}
