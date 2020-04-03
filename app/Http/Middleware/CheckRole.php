<?php

namespace App\Http\Middleware;

use Closure;

class CheckRole
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param string $role
     * @param string $page
     * @return mixed
     */
    public function handle($request, Closure $next, $role, $page)
    {
        if($request->user() === null){
            return redirect('errors/404');
        }

        return $next($request);
    }
}
