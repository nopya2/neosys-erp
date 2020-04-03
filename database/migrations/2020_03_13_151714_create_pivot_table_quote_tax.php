<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePivotTableQuoteTax extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('quote_tax', function (Blueprint $table) {
            $table->unsignedBigInteger('quote_id')->nullable();
            $table->index('quote_id');
            $table->foreign('quote_id')->references('id')->on('quotes')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->unsignedBigInteger('tax_id')->nullable();
            $table->index('tax_id');
            $table->foreign('tax_id')->references('id')->on('taxes')
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
        Schema::dropIfExists('pivot_table_quote_tax');
    }
}
