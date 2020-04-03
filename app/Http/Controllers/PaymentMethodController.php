<?php

namespace App\Http\Controllers;

use App\PaymentMethod;
use App\Http\Resources\PaymentMethod as PaymentMethodResource;
use Illuminate\Http\Request;

class PaymentMethodController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $methods = PaymentMethod::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->paginate(5);


        return PaymentMethodResource::collection($methods);
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

        $data = $request->validate([
            'name' => ['required'],
        ]);

        //On cree d'abord le devis
        $method = PaymentMethod::forceCreate([
            'name' => $data['name'],
        ]);

        return new PaymentMethodResource($method);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\PaymentMethod  $paymentMethod
     * @return \Illuminate\Http\Response
     */
    public function show(PaymentMethod $paymentMethod)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\PaymentMethod  $paymentMethod
     * @return \Illuminate\Http\Response
     */
    public function edit(PaymentMethod $paymentMethod)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\PaymentMethod  $paymentMethod
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $method = PaymentMethod::findOrFail($request->id);

        $data = $request->validate([
            'name' => ['required'],
        ]);

        $method->name = $data['name'];

        $method->save();

        return new PaymentMethodResource($method);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\PaymentMethod  $paymentMethod
     * @return \Illuminate\Http\Response
     */
    public function destroy($method)
    {
//        if (!Gate::allows('isAdmin')) {
//            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
//        }

        $method = PaymentMethod::find($method);

        if($method->delete()){
            return new PaymentMethodResource($method);
        }
    }
}
