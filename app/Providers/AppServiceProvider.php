<?php

namespace App\Providers;

use DB;
use App;
use App\Models\Language;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Schema;
use Illuminate\Translation\FileLoader;
use Illuminate\Translation\Translator;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    public function boot()
    {
        Schema::defaultStringLength(191);
        $this->app->bind(\App\ViewModels\ISmsModel::class,\App\ViewModels\SmsModel::class);

        if (Schema::hasTable('translations')) {
            if (Schema::hasColumn('languages', 'is_default'))
                $language = Language::getDefaultLanguage();

            if (isset($language)) {
                $translations = DB::table('translations')
                    ->where('locale', $language->language)
                    ->get()
                    ->mapWithKeys(function ($item) {
                        return [$item->group . '.' . $item->key => $item->value];
                    })
                    ->toArray();
                    // dd(Cookie::get('language'), $language->language);
                    if (!empty($translations)) {
                        app('translator')->addLines($translations, $language->language);
                    }
            }
        }
    }
}
