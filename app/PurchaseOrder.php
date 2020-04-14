<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PurchaseOrder extends Model
{
    protected $fillable = [
        'id', 'customer_id', 'user_id', 'purchase_order_number', 'title', 'amount_et', 'discount', 'amount_discount', 'amount', 'amount_taxes'
        , 'created_at', 'updated_at', 'expire_at', 'status'
    ];

    protected $casts = [
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

    public function taxes()
    {
        return $this->belongsToMany('App\Tax');
    }

    public function items()
    {
        return $this->morphMany('App\Item', 'itemable');
    }

}
