<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('reward_point_tiers', function (Blueprint $table) {
            $table->text('benefits')->nullable()->after('deduction_amount_unit');
        });
    }

    public function down(): void
    {
        Schema::table('reward_point_tiers', function (Blueprint $table) {
            $table->dropColumn('benefits');
        });
    }
};
