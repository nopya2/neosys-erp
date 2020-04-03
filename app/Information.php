<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Information extends Model
{
    protected $fillable = [
        'id', 'social_reason', 'logo', 'address', 'phone1', 'phone2', 'email', 'country', 'city', 'bp'
        , 'website', 'check_payable_to', 'transfer_to_account', 'code_bank', 'counter_code', 'account_number',
        'rib_key', 'footer', 'header', 'quote_delay', 'invoice_delay', 'created_at', 'updated_at'
    ];
}
