<?php

namespace App;

use App\Providers\Functions;
use Illuminate\Database\Eloquent\Model;

class Quote extends Model
{
    protected $fillable = [
        'id', 'customer_id', 'user_id', 'quote_number', 'title', 'amount_et', 'discount', 'amount_discount', 'amount', 'amount_taxes'
        , 'created_at', 'updated_at', 'expire_at', 'expired', 'is_billed', 'status'
    ];

    protected $casts = [
        'expired' => 'boolean',
        'expire_at' => 'datetime',
        'created_at' => 'datetime',
        'is_billed' => 'boolean'
    ];

    public function customer()
    {
        return $this->belongsTo('App\Customer');
    }

    public function user()
    {
        return $this->belongsTo('App\User');
    }

    public function taxes()
    {
        return $this->belongsToMany('App\Tax');
    }

    public function items()
    {
        return $this->belongsToMany('App\Item');
    }

    public function getDeadlineAttribute(){

        $now = new \DateTime();
        $formatedDate = $now->format('Y-m-d');
        $interval = $this->expire_at->diff($now);

        return $interval;
    }

    public function getExpiredAttribute(){
        if($this->is_billed === true)
            return false;
        if($this->getDeadlineAttribute()->invert == 0){
            return true;
        }

        return false;
    }

}
