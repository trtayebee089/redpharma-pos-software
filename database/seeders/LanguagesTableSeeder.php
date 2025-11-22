<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LanguagesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {

        if (!DB::table('languages')->count()) {

            DB::table('languages')->insert(array (
                0 =>
                array (
                    'id' => 1,
                    'language' => 'en',
                    'created_at' => '2025-02-15 19:31:18',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'English',
                    'is_default' => 1,
                ),
                1 =>
                array (
                    'id' => 2,
                    'language' => 'bn',
                    'created_at' => '2025-02-15 19:31:36',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'Bangla',
                    'is_default' => 0,
                ),
                2 =>
                array (
                    'id' => 7,
                    'language' => 'ar',
                    'created_at' => '2025-02-16 11:54:58',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'Arabic',
                    'is_default' => 0,
                ),
                3 =>
                array (
                    'id' => 10,
                    'language' => 'al',
                    'created_at' => '2025-02-20 19:07:34',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'Albania',
                    'is_default' => 0,
                ),
                4 =>
                array (
                    'id' => 11,
                    'language' => 'az',
                    'created_at' => '2025-02-23 10:43:59',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'Azerbaijan',
                    'is_default' => 0,
                ),
                5 =>
                array (
                    'id' => 12,
                    'language' => 'bg',
                    'created_at' => '2025-02-23 10:52:01',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'Bulgaria',
                    'is_default' => 0,
                ),
                6 =>
                array (
                    'id' => 13,
                    'language' => 'de',
                    'created_at' => '2025-02-23 11:04:53',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'Germany',
                    'is_default' => 0,
                ),
                7 =>
                array (
                    'id' => 14,
                    'language' => 'es',
                    'created_at' => '2025-02-23 11:10:30',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'Spanish',
                    'is_default' => 0,
                ),
                8 =>
                array (
                    'id' => 15,
                    'language' => 'fr',
                    'created_at' => '2025-02-23 14:12:28',
                    'updated_at' => '2025-02-23 14:24:00',
                    'name' => 'French',
                    'is_default' => 0,
                ),
            ));
        }


    }
}
