<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class CreditNote extends JsonResource
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
            'invoice_id' => $this->invoice_id,
            'user_id' => $this->user_id,
            'credit_note_number' => $this->credit_note_number,
            'type' => $this->type,
            'amount' => $this->amount,
            'percent_discount' => $this->percent_discount,
            'amount_discount' => $this->amount_discount,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'invoice' => $this->invoice,
            'user' => $this->user,
            'customer' => $this->customer,
            'text_type' => $this->text_type,
        ];
    }
}
