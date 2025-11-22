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
        Schema::create('riders', function (Blueprint $table) {
            $table->increments('id');
            $table->string('full_name', 255);
            $table->string('phone', 50)->unique();
            $table->string('nid', 100)->nullable()->unique();
            $table->text('address')->nullable();
            $table->string('emergency_contact', 50)->nullable();
            
            // Rider statistics
            $table->unsignedInteger('completed_orders')->default(0);
            $table->unsignedInteger('canceled_orders')->default(0);
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('riders');
    }
};
