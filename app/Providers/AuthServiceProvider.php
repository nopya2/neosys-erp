<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;
//use Illuminate\Auth\Access\Gate as GateContract;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        // 'App\Model' => 'App\Policies\ModelPolicy',
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        //Check for Admin
        //return true if auth user is admin
        Gate::define('isAdmin', function ($user){
            return $user->role == 'admin';
        });

        //Check for Manager
        //return true if auth user is manager
        Gate::define('isManager', function ($user){
            return $user->role == 'admin' || $user->role == 'manager';
        });

        //
    }
}
