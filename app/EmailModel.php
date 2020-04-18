<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmailModel extends Model
{
    protected $fillable = [
        'id', 'type', 'name', 'object', 'sender_name', 'sender_email', 'second_receiver', 'body', 'description'
    ];

    protected $casts = [
        'second_receiver' => 'boolean',
    ];
}
