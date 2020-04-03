<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateInvoiceRecurrenceDatesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('invoice_recurrence_date', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('invoice_recurrence_id')->nullable();
            $table->dateTime('date')->nullable();

            $table->timestamps();

            $table->index('invoice_recurrence_id');
            $table->foreign('invoice_recurrence_id')->references('id')->on('invoice_recurrence')
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
        Schema::dropIfExists('invoice_recurrence_date');
    }
}
