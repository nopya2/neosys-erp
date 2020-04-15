<?php

namespace App\Providers;

use App\CreditNote;
use App\Information;
use App\Invoice;
use App\PurchaseOrder;
use App\Quote;

class Functions{

    public static function stringToDate($dateExcel){

        if($dateExcel === '' || $dateExcel === NULL)
            return NULL;

        if(gettype($dateExcel) === 'integer'){
            $date = date('Y-m-d 00:00', intval((intval($dateExcel) - 25569)*24*60*60 ));
            return $date;
        }elseif (strpos($dateExcel, '/') !== false){
            $array = explode('/', $dateExcel);
            $finalDateExcel = $array[2].'-'.$array[1].'-'.$array[0].' 00:00';

            return new \DateTime($finalDateExcel);
        }else{
            return NULL;
        }

    }

    public static function generateQuoteNumber(){
        $lastQuote = Quote::where('quote_number', 'LIKE', '%%')
            ->orderBy('quote_number', 'desc')
            ->first();


        $temp = 1000000 + 1;
        $tempChar = strval($temp);

        if($lastQuote){
            $temp = 1000000 + intval(substr($lastQuote->quote_number, 1, 6)) + 1;
            $tempChar = strval($temp);
        }

        return 'D'.substr($tempChar, 1, 6);
    }

    public static function generatePurchaseOrderNumber(){
        $last_purchase_order = PurchaseOrder::where('purchase_order_number', 'LIKE', '%%')
            ->orderBy('purchase_order_number', 'desc')
            ->first();


        $temp = 1000000 + 1;
        $tempChar = strval($temp);

        if($last_purchase_order){
            $temp = 1000000 + intval(substr($last_purchase_order->purchase_order_number, 2, 6)) + 1;
            $tempChar = strval($temp);
        }

        return 'BC'.substr($tempChar, 2, 6);
    }

    /*
     * Numerotation de la facture
     * "FANNEEMOISNUMERO"
     * F: pour facture
     * NUMERO: a 5 chiffres
     */
    public static function generateInvoiceNumber(){
        $year = (new \DateTime())->format('Y');
        $month = (new \DateTime())->format('m');
        $indice = 10001;
        $numberToString = substr(strval($indice), 1);

        $last_invoice = Invoice::where('invoice_number', 'LIKE', '%%')
            ->orderBy('invoice_number', 'desc')
            ->first();

        if($last_invoice){
            $number = $indice + intval(substr($last_invoice->invoice_number, 7));
            $numberToString = substr(strval($number), 1);
        }

        return 'F'.$year.$month.$numberToString;
    }

    public static function informations(){
        $information = Information::find(1);

        return $information;
    }
}