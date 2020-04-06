<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Information extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'social_reason' => $this->social_reason,
            'logo' => $this->logo,
            'address' => $this->address,
            'phone1' => $this->phone1,
            'phone2' => $this->phone2,
            'email' => $this->email,
            'country' => $this->country,
            'city' => $this->city,
            'bp' => $this->bp,
            'website' => $this->website,
            'check_payable_to' => $this->check_payable_to,
            'transfer_to_account' => $this->transfer_to_account,
            'code_bank' => $this->code_bank,
            'counter_code' => $this->counter_code,
            'account_number' => $this->account_number,
            'rib_key' => $this->rib_key,
            'footer' => $this->footer,
            'header' => $this->header,
            'quote_delay' => $this->quote_delay,
            'invoice_delay' => $this->invoice_delay,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'purchase_order_delay' => $this->purchase_order_delay

        ];
    }
}
