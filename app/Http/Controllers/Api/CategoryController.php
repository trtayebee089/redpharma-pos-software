<?php

namespace App\Http\Controllers\Api;

use App\Models\Product;
use App\Models\Category;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Cache;

class CategoryController extends Controller
{
    // Generate unique slugs for categories
    public function bootSlug()
    {
        $categories = Category::select('id', 'name', 'slug')->get();

        foreach ($categories as $category) {
            $baseSlug = Str::slug($category->name);
            $slug = $baseSlug;
            $counter = 1;

            while (Category::where('slug', $slug)->where('id', '!=', $category->id)->exists()) {
                $slug = $baseSlug . '-' . $counter++;
            }

            $category->slug = $slug;
            $category->save();
        }

        return response()->json([
            'success' => true,
            'message' => 'Category slugs applied successfully',
        ]);
    }

    // Get all top-level categories with children
    public function index()
    {
        $categories = Cache::remember('categories_with_children', 3600, function () {
            $parents = Category::where('is_active', 1)
                ->whereNull('parent_id')
                ->select('id', 'name', 'slug', 'image', 'parent_id')
                ->orderBy('name')
                ->get();

            $parents->load(['children' => function ($query) {
                $query->where('is_active', 1)
                    ->select('id', 'name', 'slug', 'image', 'parent_id')
                    ->withCount('product');
            }]);

            $parents->map(function ($parent) {
                $parent->total_products = $parent->children->sum('product_count');
                return $parent;
            });

            return $parents;
        });

        return response()->json([
            'success' => true,
            'data' => $categories,
        ]);
    }


    // Show category and paginated products
    public function show(Request $request, $cat_slug)
    {
        $category = Category::select('id', 'name', 'slug', 'image', 'parent_id')
            ->where('slug', $cat_slug)
            ->with('children:id,parent_id') // only IDs
            ->first();

        if (!$category) {
            return response()->json([
                'success' => false,
                'message' => 'Category not found',
            ], 404);
        }

        // Collect category IDs including children
        $categoryIds = collect([$category->id])
            ->merge($category->children->pluck('id'))
            ->toArray();

        // Query products with only required fields and relationships
        $query = Product::select('id', 'name', 'slug', 'category_id', 'brand_id', 'price', 'image', 'promotion_price', 'qty')
            ->whereIn('category_id', $categoryIds)
            ->where('price', '>=', 0)
            ->where('qty', '>', 0)
            ->with([
                'brand:id,title',
                'category',
                'category.parent'
            ]);

        // Sorting
        if ($request->has('sort')) {
            switch ($request->sort) {
                case 'priceAsc':
                    $query->orderBy('price', 'asc');
                    break;
                case 'priceDesc':
                    $query->orderBy('price', 'desc');
                    break;
                case 'nameAsc':
                    $query->orderBy('name', 'asc');
                    break;
                case 'nameDesc':
                    $query->orderBy('name', 'desc');
                    break;
            }
            Log::info("Sorting Applied: " . $request->sort);
        }

        $products = $query->paginate(20); // Pagination already keeps memory low

        return response()->json([
            'success'  => true,
            'data' => $category,
            'products' => $products,
        ]);
    }
}
