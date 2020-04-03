<?php

namespace App\Http\Controllers;

use App\CreditNote;
use App\Http\Resources\CreditNote as CreditNoteResource;
use App\Invoice;
use App\Providers\Functions;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use NumberToWords\NumberToWords;
use PDF;

class CreditNoteController extends Controller
{
    public function home()
    {
        return view('admin.credit_notes.index', [
            'page' => 'credit_note',
            'sub_page' => 'credit_note.list'
        ]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $invoices = CreditNote::where('type', 'LIKE', $request->type)
            ->where(function ($query) use ($request){
                $query
                    ->where('credit_note_number', 'LIKE', '%' . $request->keyword . '%')
                    ->orWhereHas('invoice', function ($query) use ($request){
                        $query
                            ->whereHas('customer', function ($query) use ($request){
                                $query
                                    ->where('company_name', 'LIKE', '%' . $request->keyword . '%');
                            })
                            ->orWhere('invoice_number', 'LIKE', '%' . $request->keyword . '%');
                    });
            })
            ->orderBy('id', 'desc')
            ->paginate(10);


        return CreditNoteResource::collection($invoices);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $invoice = Invoice::findOrFail($request->i);

        return view('admin.credit_notes.create', [
            'page' => 'credit_note',
            'sub_page' => 'credit_note.create',
            'invoice' => $invoice,
        ]);
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
            'invoice_id' => ['required'],
            'type' => ['required'],
            'amount' => ['required'],
            'percent_discount' => ['required'],
            'amount_discount' => ['required'],
        ]);

        $creditNote = CreditNote::forceCreate([
            'invoice_id' => $data['invoice_id'],
            'user_id' => $currentUser->id,
            'type' => $data['type'],
            'amount' => $data['amount'],
            'percent_discount' => $data['percent_discount'],
            'amount_discount' => $data['amount_discount'],
            'credit_note_number' => Functions::generateInvoiceNumber(),
            'created_at' => new \DateTime(),
            'updated_at' => new \DateTime(),
        ]);

        return new CreditNoteResource($creditNote);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\CreditNote  $creditNote
     * @return \Illuminate\Http\Response
     */
    public function show(CreditNote $creditNote)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\CreditNote  $creditNote
     * @return \Illuminate\Http\Response
     */
    public function edit(CreditNote $creditNote)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\CreditNote  $creditNote
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, CreditNote $creditNote)
    {
        //
    }

    public function printCreditNote($creditNote){
        $information = Functions::informations();
        $creditNote = CreditNote::findOrFail($creditNote);
        $numberToWords = new NumberToWords();
        $numberTransformer = $numberToWords->getNumberTransformer('fr');
        $amountToWords =  $numberTransformer->toWords(ceil($creditNote->amount));

        //On calcule la somme des taxes
        $sumTaxes = 0;
        foreach ($creditNote->invoice->taxes as $tax){
            $sumTaxes += $tax->value/100;
        }

        //On calcule le THT en fonction du montant de l'avoir
        $tHt = $creditNote->amount /((1 - $creditNote->invoice->discount/100)*(1 + $sumTaxes));

        $pdf = PDF::loadView('admin.credit_notes.pdf_credit_note', [
            'credit_note' => $creditNote,
            'amount_to_words' => $amountToWords,
            'information' => $information,
            'total_HT' => $tHt
        ]);

        // (Optional) Setup the paper size and orientation
        $pdf->setPaper('A4', 'portrait');

        return $pdf->stream('NST-CN'.$creditNote->credit_note_number.'.pdf');
    }

    public function sendEmail(Request $request){
        $information = Functions::informations();
        $creditNote = CreditNote::findOrFail($request->id);

        //On genere le pdf de la facture
        $numberToWords = new NumberToWords();
        $numberTransformer = $numberToWords->getNumberTransformer('fr');
        $amountToWords =  $numberTransformer->toWords(ceil($creditNote->amount));

        //On calcule la somme des taxes
        $sumTaxes = 0;
        foreach ($creditNote->invoice->taxes as $tax){
            $sumTaxes += $tax->value/100;
        }

        //On calcule le THT en fonction du montant de l'avoir
        $tHt = $creditNote->amount /((1 - $creditNote->invoice->discount/100)*(1 + $sumTaxes));

        $pdf = PDF::loadView('admin.credit_notes.pdf_credit_note', [
            'credit_note' => $creditNote,
            'amount_to_words' => $amountToWords,
            'information' => $information,
            'total_HT' => $tHt
        ]);

        // (Optional) Setup the paper size and orientation
        $pdf->setPaper('A4', 'portrait');
        $filePath = public_path('uploads/documents/credit-notes/temp/').'NST-I'.$creditNote->credit_note_number.'.pdf';
        file_put_contents($filePath, $pdf->output());

        $to_name = $creditNote->invoice->customer->company_name;
        $to_email = $creditNote->invoice->customer->email;
        $data = array('credit_note'=>$creditNote);
        Mail::send('emails.credit_note', $data, function($message) use ($to_name, $to_email, $information, $creditNote, $filePath) {
            $message->to($to_email, $to_name)
                ->subject('Avoir N° '.$creditNote->credit_note_number);
            $message->from($information->email,$information->social_reason);
            $message->attach($filePath);
        });

        return new CreditNoteResource($creditNote);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\CreditNote  $creditNote
     * @return \Illuminate\Http\Response
     */
    public function destroy($creditNote)
    {
        $creditNote = CreditNote::find($creditNote);

        if($creditNote->delete()){
            return new CreditNoteResource($creditNote);
        }
    }
}
