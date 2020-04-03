<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Providers\Functions;

class Invoice extends Model
{
    protected $fillable = [
        'id', 'customer_id', 'user_id', 'invoice_number', 'title', 'amount_et', 'discount', 'amount_discount', 'amount', 'amount_taxes'
        , 'created_at', 'updated_at', 'expire_at', 'expired', 'status'
    ];

    protected $casts = [
        'expired' => 'boolean',
        'expire_at' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function customer()
    {
        return $this->belongsTo('App\Customer');
    }

    public function user()
    {
        return $this->belongsTo('App\User');
    }

    public function quote()
    {
        return $this->belongsTo('App\Quote');
    }

    public function taxes()
    {
        return $this->belongsToMany('App\Tax');
    }

    public function items()
    {
        return $this->belongsToMany('App\Item');
    }

    public function payments()
    {
        return $this->hasMany('App\Payment');
    }

    public function recurrence()
    {
        return $this->hasOne('App\InvoiceRecurrence');
    }

    public function getDeadlineAttribute(){

        $now = new \DateTime();
        $formatedDate = $now->format('Y-m-d');
        $interval = $this->expire_at->diff($now);

        return $interval;
    }

    public function getExpiredAttribute(){
        if($this->getDeadlineAttribute()->invert == 0){
            return true;
        }

        return false;
    }

    public function getIsPaidAttribute(){
        if($this->getAmountPaidAttribute() >= $this->amount) return true;
        return false;
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

    public function getExpireAtAttribute(){
        $informations = Functions::informations();
        return $this->updated_at->add(new \DateInterval('P'.$informations->invoice_delay.'D'));
    }

}
