<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePivotTablePaymentDocument extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('payment_document', function (Blueprint $table) {
            $table->unsignedBigInteger('payment_id')->nullable();
            $table->index('payment_id');
            $table->foreign('payment_id')->references('id')->on('payments')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->unsignedBigInteger('document_id')->nullable();
            $table->index('document_id');
            $table->foreign('document_id')->references('id')->on('documents')
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
        Schema::dropIfExists('payment_document');
    }
}
