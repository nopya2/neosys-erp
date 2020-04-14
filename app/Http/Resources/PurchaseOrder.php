<?php

namespace App\Http\Resources;

use App\Http\Resources\Customer as CustomerResource;
use Illuminate\Http\Resources\Json\JsonResource;

class PurchaseOrder extends JsonResource
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
            'purchase_order_number' => $this->purchase_order_number,
            'title' => $this->title,
            'amount_et' => $this->amount_et,
            'discount' => $this->discount,
            'amount_discount' => $this->amount_discount,
            'amount_taxes' => $this->amount_taxes,
            'amount' => $this->amount,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'expire_at' => $this->expire_at,
            'status' => $this->status,
            'customer' => new CustomerResource($this->customer),
            'user' => $this->user,
            'items' => $this->items

        ];
    }
}
