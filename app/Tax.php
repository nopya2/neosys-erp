<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Tax extends Model
{
    protected $fillable = [
        'id', 'name', 'value', 'description', 'enabled', 'created_at', 'updated_at'
    ];

    protected $casts = [
        'enabled' => 'boolean',
    ];

}
