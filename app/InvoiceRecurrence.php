<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class InvoiceRecurrence extends Model
{
    protected $fillable = [
        'id', 'user_id', 'invoice_id', 'start_date', 'end_date', 'period', 'occurence', 'created_at', 'updated_at'
    ];

    protected $casts = [
        'start_date' => 'datetime',
        'end_date' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function invoice()
    {
        return $this->belongsTo('App\Invoice');
    }

    public function dates()
    {
        return $this->hasMany('App\InvoiceRecurrenceDate');
    }
}
