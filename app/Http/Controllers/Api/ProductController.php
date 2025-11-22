<?php

namespace App\Http\Controllers\Api;

use App\Models\Product;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Barryvdh\Debugbar\Facades\Debugbar;
use Exception;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $cacheKey = 'products_' . md5(json_encode($request->all()));

        $products = cache()->remember($cacheKey, 300, function () use ($request) {
            $query = Product::select('id', 'name', 'slug', 'category_id', 'brand_id', 'price', 'qty', 'promotion_price', 'image')
                ->with([
                    'brand:id,title',
                    'category:id,name,parent_id,image',
                    'unit'
                ]);

            if ($request->filled('search')) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    $q->where('name', 'LIKE', "%$search%")
                        ->orWhere('product_details', 'LIKE', "%$search%");
                });
            }

            if ($request->filled('brand')) {
                $query->where('brand_id', $request->brand);
            }

            if ($request->filled('minPrice')) {
                $query->where('price', '>=', $request->minPrice);
            }
            if ($request->filled('maxPrice')) {
                $query->where('price', '<=', $request->maxPrice);
            }

            $query->where('qty', '>', 0);

            if ($request->filled('sort')) {
                match ($request->sort) {
                    'priceAsc' => $query->orderBy('price', 'asc'),
                    'priceDesc' => $query->orderBy('price', 'desc'),
                    'nameAsc' => $query->orderBy('name', 'asc'),
                    'nameDesc' => $query->orderBy('name', 'desc'),
                    default => null
                };
            }

            return $query->paginate(20);
        });

        return response()->json([
            'success' => true,
            'data' => $products,
        ]);
    }

    public function featured()
    {
        $products = cache()->remember('featured_products', 3600, function () {
            return Product::select('id', 'name', 'slug', 'category_id', 'brand_id', 'price', 'image', 'promotion_price', 'qty')
                ->where('featured', true)
                ->where('qty', '>', 0)
                ->orderBy('created_at', 'desc')
                ->with([
                    'brand:id,title',
                    'category',
                    'category.parent',
                    'unit'
                ])
                ->take(10)
                ->get();
        });

        return response()->json([
            'success' => true,
            'data' => $products,
        ]);
    }

    public function bestSelling(){
        $products = cache()->remember('best_selling_products', 3600, function () {
            return \App\Models\Product::select('products.id', 'products.name', 'products.slug', 'products.category_id', 'products.brand_id', 'products.price', 'products.image', 'products.promotion_price')
                ->with(['brand:id,title', 'category', 'category.parent', 'unit'])
                ->join('product_sales', 'products.id', '=', 'product_sales.product_id')
                ->selectRaw('products.*, SUM(product_sales.qty) as total_sold')
                ->where('products.qty', '>', 0) // product stock available
                ->groupBy('products.id')
                ->orderByDesc('total_sold')
                ->take(10) // top 10 best-selling
                ->get();
        });

        return response()->json([
            'success' => true,
            'data' => $products,
        ]);
    }

    public function show($slug)
    {
        $product = cache()->remember("product_{$slug}", 3600, function () use ($slug) {
            return Product::select('id', 'name', 'slug', 'category_id', 'brand_id', 'price', 'image', 'product_details', 'promotion_price', 'qty')
                ->with([
                    'brand:id,title',
                    'category',
                    'category.parent',
                    'unit'
                ])
                ->where('slug', $slug)
                ->first();
        });

        if (!$product) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found',
            ], 404);
        }

        $relatedProducts = cache()->remember("related_products_{$product->category_id}_exclude_{$product->id}", 3600, function () use ($product) {
            return Product::select('id', 'name', 'slug', 'category_id', 'price', 'image', 'promotion_price', 'qty')
                ->where('category_id', $product->category_id)
                ->where('id', '!=', $product->id)
                ->with([
                    'brand:id,title',
                    'category',
                    'category.parent'
                ])
                ->take(30)
                ->get();
        });

        return response()->json([
            'success' => true,
            'data' => $product,
            'relatedProducts' => $relatedProducts
        ]);
    }

    public function bootSlug()
    {
        Debugbar::disable();

        $chunkSize = 500;

        Product::select('id', 'name', 'slug')->orderBy('id')
            ->chunkById($chunkSize, function ($products) {
                foreach ($products as $product) {
                    $baseSlug = Str::slug($product->name);
                    $slug = $baseSlug;
                    $counter = 1;

                    while (Product::where('slug', $slug)->where('id', '!=', $product->id)->exists()) {
                        $slug = $baseSlug . '-' . $counter++;
                    }

                    Product::where('id', $product->id)->update(['slug' => $slug]);
                }
            });

        return response()->json([
            'success' => true,
            'message' => 'Product slugs applied successfully',
        ]);
    }

    public function search(Request $request, $query)
    {
        try {
            $query = trim($query);
            if (strlen($query) < 2) {
                return response()->json([
                    'success' => false,
                    'message' => 'Search query too short.',
                    'data' => [],
                ], 400);
            }

            $products = Product::with([
                    'brand:id,title',
                    'category',
                    'category.parent',
                    'unit'
                ])
                ->where(function ($q) use ($query) {
                    $q->where('name', 'like', "%{$query}%")
                        ->orWhereHas('brand', fn($b) => $b->where('title', 'like', "%{$query}%"))
                        ->orWhereHas('category', fn($c) => $c->where('name', 'like', "%{$query}%"));
                })
                ->where('qty', '>', 0)
                ->select('id', 'name', 'slug', 'brand_id', 'category_id', 'price', 'image', 'promotion_price', 'qty')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $products,
            ]);
        } catch (\Exception $e) {
            Log::error("❌ Error Searching Products", [
                'query' => $query,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Something went wrong while searching products.',
            ], 500);
        }
    }
}
