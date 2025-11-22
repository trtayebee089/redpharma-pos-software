<?php

use Database\Seeders\BarcodeSeeder;
use Database\Seeders\ExternalServicesSeeder;
use Database\Seeders\LanguagesTableSeeder;
use Database\Seeders\TranslationsTableSeeder;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(BarcodeSeeder::class);
        $this->call(ExternalServicesSeeder::class);
        $this->call(LanguagesTableSeeder::class);
        $this->call(TranslationsTableSeeder::class);
    }
}
