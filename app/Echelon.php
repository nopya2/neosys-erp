<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Echelon extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id', 'engagement_id', 'user_id', 'n_engage', 'm_paye', 'date_paiement', 'comment', 'date_depot_ac', 'created_at', 'updated_at'
    ];

    public function user()
    {
        return $this->belongsTo('App\User');
    }

    public function engagement()
    {
        return $this->belongsTo('App\Engagement');
    }
}
