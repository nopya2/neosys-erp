<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Echelon extends JsonResource
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
            'n_engage' => $this->n_engage,
            'm_paye' => $this->m_paye,
            'date_paiement' => $this->date_paiement,
            'date_depot_ac' => $this->date_depot_ac,
            'created_at	' => $this->created_at,
            'updated_at	' => $this->updated_at,
            'engagement' => $this->engagement,
            'user' => $this->user,
            'comment' => $this->comment
        ];
    }
}
