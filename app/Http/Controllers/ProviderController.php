<?php

namespace App\Http\Controllers;

use App\Echelon;
use App\Engagement;
use App\Provider;
use App\Http\Resources\Provider as ProviderResource;
use App\Http\Resources\Engagement as EngagementResource;
use App\Http\Resources\Echelon as EchelonResource;
use Illuminate\Http\Request;

class ProviderController extends Controller
{
    public function home()
    {
        return view('admin.providers.index', [
            'page' => 'provider',
            'sub_page' => 'provider.list'
        ]);
    }

    public function index(Request $request)
    {
        $providers = Provider::where('name', 'like', '%%')
            ->orderBy('name', 'ASC')
            ->get();

        return ProviderResource::collection($providers);
    }



    public function loadData(Request $request){

        $engagements = Engagement::where('l_nmtir', $request->provider)
            ->orderBy('id', 'DESC')
            ->get();

        $echelons = Echelon::whereHas('engagement', function ($query) use ($request){
                    $query->where('l_nmtir', $request->provider);
                })
            ->orderBy('id', 'desc')
            ->get();

        return [
            'engagements' => $engagements,
            'echelons' => $echelons
        ];

    }

    public function loadEngagements(Request $request){

        $engagements = Engagement::where('l_nmtir', $request->provider)
            ->where(function ($query) use ($request){
                $query
                    ->where('n_engage', 'LIKE', '%' . $request->keyword . '%')
                    ->orWhere('n_devis', 'LIKE', '%' . $request->keyword . '%');
            })
            ->orderBy('id', 'DESC')
            ->paginate(10);

        return EngagementResource::collection($engagements);

    }

    public function loadEchelons(Request $request){

        $echelons = Echelon::whereHas('engagement', function ($query) use ($request){
                $query
                    ->where('l_nmtir', $request->provider)
                    ->where(function ($query) use ($request){
                        $query
                            ->where('n_engage', 'LIKE', '%' . $request->keyword . '%')
                            ->orWhere('n_devis', 'LIKE', '%' . $request->keyword . '%');
                    });
            })
            ->orderBy('id', 'desc')
            ->paginate(10);

        return EchelonResource::collection($echelons);

    }
}
