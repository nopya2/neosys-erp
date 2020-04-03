<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CreditNote extends Model
{
    protected $fillable = [
        'id', 'invoice_id', 'user_id', 'type', 'amount', 'credit_note_number', 'percent_discount', 'amount_discount', 'created_at', 'updated_at'
    ];

    public function user()
    {
        return $this->belongsTo('App\User');
    }

    public function invoice()
    {
        return $this->belongsTo('App\Invoice');
    }

    public function getCustomerAttribute(){
        return $this->invoice->customer;
    }

    public function getTextTypeAttribute(){
        switch ($this->type){
            case 1:
                return 'Avoir commercial';
                break;
            case 2:
                return 'Retour marchandise ou annulation prestation';
                break;
            case 3:
                return 'Erreur de facturation';
                break;
        }
    }
}
