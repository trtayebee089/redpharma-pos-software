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
        Schema::create('shipping_zones', function (Blueprint $table) {
            $table->id();
            $table->string('division');
            $table->string('district')->nullable();
            $table->string('thana')->nullable();
            $table->decimal('rate', 10, 2)->default(0);
            $table->string('estimated_delivery')->nullable();
            $table->decimal('min_order_amount', 10, 2)->default(0);
            $table->boolean('is_active')->default(true);
            $table->enum('delivery_partner', ['pathao', 'redx', 'steadfast', 'sundarban', 'sa-paribahan'])->nullable();
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('shipping_zones');
    }
};
