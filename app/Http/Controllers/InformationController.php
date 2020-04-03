<?php

namespace App\Http\Controllers;

use App\Information;
use App\Http\Resources\Information as InformationResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class InformationController extends Controller
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
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Information  $information
     * @return \Illuminate\Http\Response
     */
    public function show(Information $information)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Information  $information
     * @return \Illuminate\Http\Response
     */
    public function edit()
    {
        $information = Information::findOrFail(1);

        return view('admin.information', [
            'information' => $information,
            'page' => 'information',
            'sub_page' => 'information.index'
        ]);
    }


    public function update(Request $request)
    {
        $information = Information::findOrFail($request->id);

        $data = $request->validate([
            'social_reason' => ['required'],
            'address' => ['required'],
            'phone1' => ['required'],
            'phone2' => [],
            'email' => ['required'],
            'country' => ['required'],
            'city' => ['required'],
            'bp' => [],
            'website' => [],
            'check_payable_to' => ['required'],
            'transfer_to_account' => ['required'],
            'code_bank' => [],
            'counter_code' => [],
            'account_number' => [],
            'rib_key' => [],
            'header' => [],
            'footer' => ['required'],
            'quote_delay' => [],
            'invoice_delay' => [],
            'updated_at' => [],
        ]);

        $information->social_reason = $data['social_reason'];
        $information->address = $data['address'];
        $information->phone1 = $data['phone1'];
        $information->phone2 = $data['phone2'];
        $information->email = $data['email'];
        $information->country = $data['country'];
        $information->city = $data['city'];
        $information->bp = $data['bp'];
        $information->website = $data['website'];
        $information->check_payable_to = $data['check_payable_to'];
        $information->transfer_to_account = $data['transfer_to_account'];
        $information->code_bank = $data['code_bank'];
        $information->counter_code = $data['counter_code'];
        $information->account_number = $data['account_number'];
        $information->rib_key = $data['rib_key'];
        $information->header = $data['header'];
        $information->footer = $data['footer'];
        $information->quote_delay = $data['quote_delay'];
        $information->invoice_delay = $data['invoice_delay'];
        $information->updated_at = new \DateTime();

        $information->save();

        return new InformationResource($information);
    }

    public function updatePicture(Request $request){
        $information = Information::find($request->id);
        $fileName = 'logo.'.$request->file->extension();
        $information->logo = $fileName;
        $information->save();

        $request->file->move(public_path('img/uploads/logo'), $fileName);

        return new InformationResource($information);
    }

    public function sendMail(){
        $to_name = 'DECIMA';
        $to_email = 'nopya2@gmail.com';
        $data = array('name'=>"Ogbonna Vitalis(sender_name)", 'body' => "A test mail");
        Mail::send('emails.test', $data, function($message) use ($to_name, $to_email) {
            $message->to($to_email, $to_name)
                ->subject('Laravel Test Mail');
            $message->from('infos@neosystechnologie.ga','Neosys Technologie');
            $message->attach(public_path('uploads/documents/payments/5e80c884db020.pub'));
        });
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Information  $information
     * @return \Illuminate\Http\Response
     */
    public function destroy(Information $information)
    {
        //
    }
}
