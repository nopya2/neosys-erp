<?php

namespace App\Http\Resources;

use App\Http\Resources\Customer as CustomerResource;
use Illuminate\Http\Resources\Json\JsonResource;

class Quote extends JsonResource
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
            'customer_id' => $this->customer_id,
            'user_id' => $this->user_id,
            'quote_number' => $this->quote_number,
            'title' => $this->title,
            'amount_et' => $this->amount_et,
            'discount' => $this->discount,
            'amount_discount' => $this->amount_discount,
            'amount_taxes' => $this->amount_taxes,
            'amount' => $this->amount,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'customer' => new CustomerResource($this->customer),
            'user' => $this->user,
            'expire_at' => $this->expire_at,
            'expired' => $this->expired,
            'taxes' => $this->taxes,
            'items' => $this->items,
            'deadline' => $this->deadline,
            'is_billed' => $this->is_billed,

        ];
    }
}
