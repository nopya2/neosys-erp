<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class User extends JsonResource
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
            'name' => $this->name,
            'firstname' => $this->firstname,
            'username' => $this->username,
            'email' => $this->email,
            'phonenumber' => $this->phonenumber,
            'role' => $this->role,
            'status' => $this->status,
            'api_token' => $this->api_token,
            'fonction' => $this->fonction,
            'avatar' => $this->avatar
        ];
    }
}
