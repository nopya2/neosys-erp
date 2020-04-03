<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    protected $fillable = [
        'id', 'user_id', 'invoice_id', 'payment_method_id', 'amount', 'description', 'created_at'
    ];

    public function user()
    {
        return $this->belongsTo('App\User');
    }

    public function invoice()
    {
        return $this->belongsTo('App\Invoice');
    }

    //Methodes de paiement
    public function method()
    {
        return $this->belongsTo('App\PaymentMethod');
    }

    public function documents()
    {
        return $this->belongsToMany('App\Document');
    }
}
