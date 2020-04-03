<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    protected $fillable = [
        'id', 'pu', 'qty', 'label', 'amount', 'created_at', 'updated_at'
    ];
}
