<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('reward_point_tiers', function (Blueprint $table) {
            $table->boolean('deduction_enabled')->default(false);
            $table->decimal('deduction_rate_per_unit', 8, 2)->default(0);
            $table->decimal('deduction_amount_unit', 8, 2)->default(100);
        });
    }

    public function down(): void
    {
        Schema::table('reward_point_tiers', function (Blueprint $table) {
            $table->dropColumn(['deduction_enabled', 'deduction_rate_per_unit', 'deduction_amount_unit']);
        });
    }
};
