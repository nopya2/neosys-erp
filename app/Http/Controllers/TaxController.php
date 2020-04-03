<?php

namespace App\Http\Controllers;

use App\Tax;
use App\Http\Resources\Tax as TaxResource;
use Illuminate\Http\Request;

class TaxController extends Controller
{
    public function home()
    {
        return view('admin.taxes.index', [
            'page' => 'tax',
            'sub_page' => 'tax.list'
        ]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $taxes = Tax::where('name', 'LIKE', '%' . $request->keyword . '%')
            ->orderBy('name', 'asc')
            ->paginate(10);

        return TaxResource::collection($taxes);
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
            'value' => ['required'],
            'description' => ['required'],
            'enabled' => []
        ]);

        $tax = Tax::forceCreate([
            'name' => $data['name'],
            'value' => $data['value'],
            'description' => $data['description'],
            'enabled' => $data['enabled']
        ]);

        return new TaxResource($tax);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Tax  $tax
     * @return \Illuminate\Http\Response
     */
    public function show(Tax $tax)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Tax  $tax
     * @return \Illuminate\Http\Response
     */
    public function edit(Tax $tax)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Tax  $tax
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $data = $request->validate([
            'name' => ['required'],
            'value' => ['required'],
            'description' => ['required'],
        ]);

        $tax = Tax::find($request->id);

        $tax->value = $request->value;
        $tax->name = $request->name;
        $tax->description = $request->description;
        $tax->enabled = $request->enabled;

        $tax->save();

        return new TaxResource($tax);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Tax  $tax
     * @return \Illuminate\Http\Response
     */
    public function destroy($tax)
    {
        $tax = Tax::find($tax);

        if($tax->delete()){
            return new TaxResource($tax);
        }
    }
}
