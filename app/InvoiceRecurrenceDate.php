<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class InvoiceRecurrenceDate extends Model
{
    protected $fillable = [
        'id', 'invoice_recurrence_id', 'date', 'created_at', 'updated_at'
    ];

    protected $casts = [
        'date' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function recurrence()
    {
        return $this->belongsTo('App\InvoiceRecurrence');
    }
}
