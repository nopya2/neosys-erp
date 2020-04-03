<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Document extends Model
{
    protected $fillable = [
        'id', 'filename', 'created_at', 'updated_at'
    ];

    public function documents()
    {
        return $this->belongsToMany('App\Document');
    }
}
