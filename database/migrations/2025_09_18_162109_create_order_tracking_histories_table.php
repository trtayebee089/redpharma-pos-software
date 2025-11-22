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
        Schema::create('order_tracking_histories', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('tracking_id');
            $table->foreign('tracking_id')->references('id')->on('order_trackings')->onDelete('cascade');
            $table->string('status'); // pending, processing, in_transit, delivered
            $table->text('note')->nullable(); // optional message
            $table->timestamp('created_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_tracking_histories');
    }
};
