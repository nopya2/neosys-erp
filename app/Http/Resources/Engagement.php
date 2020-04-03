<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Engagement extends JsonResource
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
            'd_exerci' => $this->d_exerci,
            'c_dest' => $this->c_dest,
            'nat_dep' => $this->nat_dep,
            'l_dep' => $this->l_dep,
            'm_dispo' => $this->m_dispo,
            'm_toteng' => $this->m_toteng,
            'm_tengvi' => $this->m_tengvi,
            'm_totliq' => $this->m_totliq,
            'm_tordvi' => $this->m_tordvi,
            'm_totord' => $this->m_totord,
            'm_dotini' => $this->m_dotini,
            'n_engage' => $this->n_engage,
            'm_engage' => $this->m_engage,
            'date_depot_ac' => $this->date_depot_ac,
            'date_paiement' => $this->date_paiement,
            'm_paye' => $this->m_paye,
            'd_engage' => $this->d_engage,
            'mois_' => $this->mois_,
            'm_tliqenga' => $this->m_tliqenga,
            'm_non_paye' => $this->m_non_paye,
            'l_depeng' => $this->l_depeng,
            'l_nmtir' => $this->l_nmtir,
            'n_mattir' => $this->n_mattir,
            'c_mattir' => $this->c_mattir,
            'l_chap' => $this->l_chap,
            'n_devis' => $this->n_devis,
            'nip' => $this->nip,
            'r_engage' => $this->r_engage,
            'desc_r_engage' => $this->desc_r_engage,
            'v_m_paye' => $this->v_m_paye,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'echelons' => $this->echelons,
            'is_late' => $this->isLate
            
        ];
    }
}
