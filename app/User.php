<?php

namespace App;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id', 'name', 'email', 'firstname', 'username', 'password', 'phonenumber', 'status', 'role', 'created_at',
        'updated_at', 'fonction'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token', 'api_token'
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function formatName(){
//        $name = "";
        $nameArray = explode(' ', $this->name);
        if(count($nameArray) > 1){
            $name = $nameArray[0];
            for ($i=1; $i <= count($nameArray) - 1; $i++){
                $name .= " " . substr($nameArray[$i], 0, 1).".";

            }
        }else{
            $name = $this->name;
        }

//        $firstname = "";
        $firstnameArray = explode(' ', $this->firstname);
        if(count($firstnameArray) > 1){
            $firstname = $firstnameArray[0];
            for ($i=1; $i <= count($firstnameArray) - 1; $i++){
                $firstname .= " " . strtoupper(substr($firstnameArray[$i], 0, 1).".");

            }
        }
        else{
            $firstname = $this->firstname;
        }

        return strtoupper($name) . " " . ucfirst($firstname);
    }

}
