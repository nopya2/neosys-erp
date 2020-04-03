<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Customer extends JsonResource
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
            'company_name' => $this->company_name,
            'phonenumber' => $this->phonenumber,
            'email' => $this->email,
            'address' => $this->address,
            'bp' => $this->bp,
            'website' => $this->website,
            'country' => $this->country,
            'city' => $this->city,
            'activity' => $this->activity,
            'manager' => $this->manager,
        ];
    }
}
