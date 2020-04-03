<?php

namespace App\Http\Controllers;

use App\Echelon;
use App\Engagement;
use App\User;
use App\Provider;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
//    public function __construct()
//    {
//        $this->middleware('auth');
//    }

    public function home(){
        return view('admin.dashboard', [
            'page' => 'home',
            'sub_page' => ''
        ]);
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
//        $currentYear = date('Y');
//
//        $engagements = Engagement::where('d_exerci', $currentYear)->count();
//        $paiements = Echelon::whereBetween('date_paiement', [$currentYear.'-01-01 00:00', $currentYear.'-12-31 23:59'])->count();
//        $lastPaiements = Echelon::whereBetween('date_paiement', [$currentYear.'-01-01 00:00', $currentYear.'-12-31 23:59'])
//            ->take(7)
//            ->orderBy('date_paiement', 'DESC')
//            ->get();
//        $users = User::all()->count();
//        $providers = Provider::all()->count();
//
//        //On va recuper le CPU traffic en fonction du type d'OS utilise
//        //Pour Windows
//       $res = shell_exec('wmic cpu get loadpercentage');
//       $array = explode("\r\n", $res);
//       $memory = intval($array[1]);
//
//        //for Linux
//        // $load = sys_getloadavg();
//        // $memory = $load[0] * 100;



        return view('admin.dashboard', [
//            'engagements' => $engagements,
//            'paiements' => $paiements,
//            'last_paiements' => $lastPaiements,
//            'users' => $users,
//            'providers' => $providers,
//            'memory' => $memory,
            'page' => 'dashboard',
            'sub_page' => ''
        ]);
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function test()
    {
        return view('test');
    }
}
