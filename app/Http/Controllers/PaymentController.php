<?php

namespace App\Http\Controllers;

use App\Document;
use App\Invoice;
use App\Http\Resources\Invoice as InvoiceResource;
use App\Payment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
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
            'invoice_id' => ['required'],
            'payment_method_id' => ['required'],
            'amount' => ['required'],
            'description' => [],
        ]);

        $currentUser = Auth::user();

        $payment = Payment::forceCreate([
            'invoice_id' => $data['invoice_id'],
            'amount' => $data['amount'],
            'user_id' => $currentUser->id,
            'payment_method_id' => $data['payment_method_id'],
            'description' => $data['description'],
            'created_at' => new \DateTime(),
        ]);

        //On cree ensuite le document
        $documents = $request->documents;
        if($request->has('documents')){
            foreach ($documents as $el){
                $fileName = $el->getClientOriginalName();
                $url = uniqid().".".$el->getClientOriginalExtension();
                $el->move(public_path('uploads/documents/payments'), $url);
                $document = Document::forceCreate([
                    'filename' => $fileName,
                    'url' => $url
                ]);

                $payment->documents()->attach($document->id);
            }
        }

        $invoice = Invoice::find($data['invoice_id']);

        return new InvoiceResource($invoice);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Payment  $payment
     * @return \Illuminate\Http\Response
     */
    public function show(Payment $payment)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Payment  $payment
     * @return \Illuminate\Http\Response
     */
    public function edit(Payment $payment)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Payment  $payment
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Payment $payment)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Payment  $payment
     * @return \Illuminate\Http\Response
     */
    public function destroy(Payment $payment)
    {
        //
    }
}
