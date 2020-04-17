<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Providers\Functions;

class Invoice extends Model
{
    protected $fillable = [
        'id', 'customer_id', 'user_id', 'payment_method_id', 'invoice_number', 'title', 'amount_et', 'discount', 'amount_discount', 'amount', 'amount_taxes'
        , 'created_at', 'updated_at', 'expire_at', 'status', 'type', 'parent_id'
    ];

    protected $casts = [
        'expire_at' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function children(){
        return $this->hasMany( 'App\Invoice', 'parent_id', 'id' );
    }

    public function parent(){
        return $this->hasOne( 'App\Invoice', 'id', 'parent_id' );
    }

    public function customer()
    {
        return $this->belongsTo('App\Customer');
    }

    public function paymentMethod()
    {
        return $this->belongsTo('App\PaymentMethod');
    }

    public function user()
    {
        return $this->belongsTo('App\User');
    }

    public function taxes()
    {
        return $this->belongsToMany('App\Tax');
    }

//    public function items()
//    {
//        return $this->belongsToMany('App\Item');
//    }

    public function items()
    {
        return $this->morphMany('App\Item', 'itemable');
    }

    public function payments()
    {
        return $this->hasMany('App\Payment');
    }

    public function recurrence()
    {
        return $this->hasOne('App\InvoiceRecurrence');
    }

    public function getAmountPaidAttribute(){
        $amount = 0;
        foreach ($this->payments as $payment){
            $amount += $payment->amount;
        }

        return $amount;
    }

    public function getAmountRemainingAttribute(){
        return $this->amount - $this->getAmountPaidAttribute();
    }

    public function getShowTypeAttribute(){
        switch($this->type){
            case 'standard':
                return 'Standard';
            case 'credit_note':
                return 'Avoir';
            case 'deposit':
                return 'Accompte';
        }
    }

    /*
     * en retard: late
     * paye: paid
     * impaye: unpaid
     * en attente: waiting
     */
    public function getStateAttribute(){
        if($this->status === 'draft')
            return 'draft';
        if($this->getAmountPaidAttribute() >= $this->amount)
            return 'paid';
        if($this->getAmountPaidAttribute() <= 0 && $this->expire_at < (new \DateTime()))
            return 'unpaid';
        if(($this->getAmountPaidAttribute() > 0 && $this->getAmountPaidAttribute() < $this->amount) && $this->expire_at < (new \DateTime()))
            return 'late';
        if(($this->getAmountPaidAttribute() >= 0 && $this->getAmountPaidAttribute() < $this->amount) && $this->expire_at >= (new \DateTime()))
            return 'waiting';
    }

    public function getRemainingDaysAttribute(){
        $diff = date_diff((new \DateTime()), $this->expire_at);

        return intval($diff->format('%a'));
    }

}
