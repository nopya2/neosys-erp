<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class InvoiceRecurrenceResource extends JsonResource
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
            'user_id' => $this->user_id,
            'invoice_id' => $this->invoice_id,
            'start_date' => $this->start_date,
            'end_date' => $this->end_date,
            'period' => $this->period,
            'occurence' => $this->occurence,
            'invoice' => $this->invoice,
        ];
    }
}
