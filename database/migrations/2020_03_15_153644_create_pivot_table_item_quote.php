<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePivotTableItemQuote extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('item_quote', function (Blueprint $table) {
            $table->unsignedBigInteger('item_id')->nullable();
            $table->index('item_id');
            $table->foreign('item_id')->references('id')->on('items')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->unsignedBigInteger('quote_id')->nullable();
            $table->index('quote_id');
            $table->foreign('quote_id')->references('id')->on('quotes')
                ->onDelete('cascade')
                ->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pivot_table_item_quote');
    }
}
