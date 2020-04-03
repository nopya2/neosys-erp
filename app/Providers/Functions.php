<?php

namespace App\Providers;

use App\CreditNote;
use App\Information;
use App\Invoice;
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
            $temp = 1000000 + intval($lastQuote->quote_number) + 1;
            $tempChar = strval($temp);
        }

        return $tempChar[1].$tempChar[2].$tempChar[3].$tempChar[4].$tempChar[5].$tempChar[6];
    }

    public static function generateInvoiceNumber(){
        $lastInvoice = Invoice::where('invoice_number', 'LIKE', '%%')
            ->orderBy('invoice_number', 'desc')
            ->first();

        $lastCreditNote = CreditNote::where('credit_note_number', 'LIKE', '%%')
            ->orderBy('credit_note_number', 'desc')
            ->first();

        $number = 0;
        if($lastInvoice || $lastCreditNote){
            $number = intval($lastInvoice->invoice_number);
            if($lastCreditNote){
                if(intval($lastCreditNote->credit_note_number) > intval($lastCreditNote->invoice_number))
                    $number = intval($lastCreditNote->credit_note_number);
            }
            $temp = 1000000 + $number + 1;
            $tempChar = strval($temp);
        }
        else{
            $temp = 1000000 + 1;
            $tempChar = strval($temp);
        }
        return $tempChar[1].$tempChar[2].$tempChar[3].$tempChar[4].$tempChar[5].$tempChar[6];
    }

    public static function informations(){
        $information = Information::find(1);

        return $information;
    }
}