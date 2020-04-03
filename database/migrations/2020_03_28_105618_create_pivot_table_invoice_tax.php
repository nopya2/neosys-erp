<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePivotTableInvoiceTax extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('invoice_tax', function (Blueprint $table) {
            $table->unsignedBigInteger('invoice_id')->nullable();
            $table->index('invoice_id');
            $table->foreign('invoice_id')->references('id')->on('invoices')
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
        Schema::dropIfExists('invoice_tax');
    }
}
