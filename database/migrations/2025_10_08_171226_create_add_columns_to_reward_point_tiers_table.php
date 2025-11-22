<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('reward_point_tiers', function (Blueprint $table) {
            $table->string('color_code')->nullable();
            $table->string('color_class')->nullable();
            $table->string('icon_class')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('reward_point_tiers', function (Blueprint $table) {
            $table->dropColumn(['color_code', 'color_class', 'icon_class']);
        });
    }
};
