<?php

namespace App\Http\Controllers;

use App\Echelon;
use App\Engagement;
use App\Http\Resources\Echelon as EchelonResource;
use App\Providers\Functions;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EchelonController extends Controller
{
    public function home()
    {
        return view('admin.echelons.index', [
            'page' => 'echelon',
            'sub_page' => 'echelon.list'
        ]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $echelons = Echelon::whereBetween('date_paiement', [$request->exercice.'-01-01 00:00:00', $request->exercice.'-12-31 23:59:59'])
            ->where(function ($query) use ($request){
                $query
                    ->whereHas('engagement', function ($query) use ($request){
                        $query->where('l_nmtir', 'like', '%' . $request->keyword . '%')
                            ->orWhere('n_devis', 'like', '%' . $request->keyword . '%');
                    })
                    ->orWhere('n_engage', 'LIKE', '%' . $request->keyword . '%');
            })
            ->orderBy('id', 'desc')
            ->paginate(15);

        return EchelonResource::collection($echelons);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $currentUser = Auth::user();

        $data = $request->validate([
            'n_engage' => ['required'],
            'm_paye' => ['required'],
            'date_paiement' => ['required'],
            'date_depot_ac' => ['required'],
            'comment' => ['required']
        ]);

        //On va actualiser le v_m_engage de l'engage
        //On selectionne d'abord l'engagement qui correspond a ce numero d'engagement
        $engagement = Engagement::where('n_engage', '=', $data['n_engage'])
            ->orderBy('id', 'DESC')
            ->first();
        //Puis on met a jour les donnees
        $engagement->v_m_paye = $engagement->v_m_paye + $data['m_paye'];

        //On modifie le statut de l'engagement ('is_paid')
        if($engagement->m_engage <= $engagement->v_m_paye)
            $engagement->is_paid = true;

        $engagement->updated_at = new \DateTime();
        $engagement->save();

        $echelon = Echelon::forceCreate([
            'n_engage' => $data['n_engage'],
            'm_paye' => $data['m_paye'],
            'date_paiement' => Functions::stringToDate($data['date_paiement']),
            'date_depot_ac' => Functions::stringToDate($data['date_depot_ac']),
            'comment' => $data['comment'],
            'user_id' => $currentUser->id,
            'engagement_id' => $engagement->id
        ]);

        return new EchelonResource($echelon);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Echelon  $echelon
     * @return \Illuminate\Http\Response
     */
    public function show(Echelon $echelon)
    {
        //
    }

    public function selectByEngagementNumber(Request $request)
    {
        $echelons = Echelon::where('n_engage', '=', $request->n_engage)
            ->orderBy('id', 'DESC')
            ->get();

        return EchelonResource::collection($echelons);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Echelon  $echelon
     * @return \Illuminate\Http\Response
     */
    public function edit(Echelon $echelon)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Echelon  $echelon
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Echelon $echelon)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Echelon  $echelon
     * @return \Illuminate\Http\Response
     */
    public function destroy(Echelon $echelon)
    {
        //
    }
}
