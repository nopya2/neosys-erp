<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    protected $fillable = [
        'id', 'company_name', 'phonenumber', 'email', 'address', 'bp', 'manager_id', 'website', 'activity', 'city', 'country',
    ];

    public function users()
    {
        return $this->hasMany('App\User');
    }

    public function manager()
    {
        return $this->belongsTo('App\User');
    }
}
