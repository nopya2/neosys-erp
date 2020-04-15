<?php

namespace App\Http\Controllers;

use App\Customer;
use App\Invoice;
use App\Http\Resources\Invoice as InvoiceResource;
use App\InvoiceRecurrence;
use App\InvoiceRecurrenceDate;
use App\Item;
use App\Payment;
use App\PaymentMethod;
use App\Information;
use App\Providers\Functions;
use App\Tax;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;
use NumberToWords\NumberToWords;
use PDF;

class InvoiceController extends Controller
{
    protected $informationApp;

    public function __construct()
    {
        $this->informationApp = Information::find(1);
    }

    public function home()
    {
        return view('admin.invoices.index', [
            'page' => 'invoice',
            'sub_page' => 'invoice.list'
        ]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $invoices = Invoice::where('invoice_number', 'LIKE', '%' . $request->keyword . '%')
            ->orWhere(function ($query) use ($request){
                $query
                    ->whereHas('customer', function ($query) use ($request){
                        $query
                            ->where('company_name', 'LIKE', '%' . $request->keyword . '%');
                    })
                    ->orWhere('title', 'LIKE', '%' . $request->keyword . '%');
            })
            ->orderBy('id', 'desc')
            ->get();

        if($request->status !== '0'){
            switch($request->status){
                case '1':
                    //Facture brouillon
                    $invoices = $invoices->filter(function ($invoice) {
                        return $invoice->status == 0;
                    });
                    break;
                case '2':
                    //Facture en retard
                    $invoices = $invoices->filter(function ($invoice) {
                        return $invoice->status == 1 && $invoice->is_paid == false && $invoice->expired == true;
                    });
                    break;
                case '3':
                    //Facture en cours
                    $invoices = $invoices->filter(function ($invoice) {
                        return $invoice->status == 1 && $invoice->is_paid == false && $invoice->expired == false;
                    });
                    break;
                case '4':
                    //Facture en cours
                    $invoices = $invoices->filter(function ($invoice) {
                        return $invoice->is_paid == true;
                    });
                    break;
            }
        }


        return InvoiceResource::collection($invoices)->paginate(10);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $taxes = Tax::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->get();

        return view('admin.invoices.create', [
            'page' => 'invoice',
            'sub_page' => 'invoice.list',
            'taxes' => $taxes,
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

        try{
            $data = $request->validate([
                'title' => ['required'],
                'customer_id' => ['required'],
                'amount_et' => ['required'],
                'amount_discount' => ['required'],
                'amount' => ['required'],
                'discount' => ['required'],
                'amount_taxes' => ['required'],
            ]);

            //On cree d'abord la facture
            $invoice = Invoice::forceCreate([
                'customer_id' => $data['customer_id'],
                'user_id' => $currentUser->id,
                'invoice_number' => Functions::generateInvoiceNumber(),
                'title' => $data['title'],
                'amount_et' => $data['amount_et'],
                'discount' => $data['discount'],
                'amount_discount' => $data['amount_discount'],
                'amount_taxes' => $data['amount_taxes'],
                'amount' => $data['amount'],
                'created_at' => new \DateTime(),
                'updated_at' => new \DateTime(),
                'expire_at' => (new \DateTime())->add(new \DateInterval('P'.$this->informationApp->invoice_delay.'D')),
            ]);

            //On cree les items de la facture et on attache a la facture
            $items = $request->items;
            foreach ($items as $el){
                $item = Item::forceCreate([
                    'label' => $el['label'],
                    'pu' => doubleval($el['pu']),
                    'qty' => intval($el['qty']),
                    'amount' => doubleval($el['amount']),
                ]);

                $invoice->items()->save($item);
            }

            //On affecte les taxes au a la facture
            $taxes = $request->selected_taxes;
            foreach ($taxes as $el){
                $invoice->taxes()->attach($el['id']);
            }
        }catch (Exception $ex){
            return new JsonResponse(['message'=>$ex->getMessage()], 400);
        }


        return new InvoiceResource($invoice);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Invoice  $invoice
     * @return \Illuminate\Http\Response
     */
    public function show($invoice)
    {
        $invoice = Invoice::find($invoice);

        return new InvoiceResource($invoice);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Invoice  $invoice
     * @return \Illuminate\Http\Response
     */
    public function edit($invoice, Request $request)
    {
        $invoice = Invoice::findOrFail($invoice);

        $taxes = Tax::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->get();

        $methods = PaymentMethod::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->get();

        return view('admin.invoices.edit', [
            'invoice' => $invoice,
            'page' => 'invoice',
            'sub_page' => 'invoice.list',
            'taxes' => $taxes,
            'payment_methods' => $methods
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Invoice  $invoice
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $invoice = Invoice::findOrFail($request->id);

        try{
            $data = $request->validate([
                'invoice_number' => ['required'],
                'title' => ['required'],
                'customer_id' => ['required'],
                'amount_et' => ['required'],
                'amount_discount' => ['required'],
                'amount' => ['required'],
                'discount' => ['required'],
                'amount_taxes' => ['required'],
            ]);

            $invoice->title = $request->title;
            $invoice->amount_et = $request->amount_et;
            $invoice->discount = $request->discount;
            $invoice->amount_discount = $request->amount_discount;
            $invoice->amount_taxes = $request->amount_taxes;
            $invoice->amount = $request->amount;
            $invoice->updated_at = new \DateTime();
            $invoice->expire_at = (new \DateTime())->add(new \DateInterval('P'.$this->informationApp->invoice_delay.'D'));
            $invoice->status = $request->status;

            $invoice->save();

            //On detache d'abord tous les items
            $invoice->items()->delete();
            //On cree les nouveaux items de la facture et on attache au devis
            $items = $request->items;
            foreach ($items as $el){
                //On verifie d'abord si l'id de l'item existe
                //Si il existe, on modifie les informations
                //Si il n'existe pas on cree de nouveaux items
                $item = Item::find($el['id']);
                if(!empty($item)){
                    $item->label = $el['label'];
                    $item->pu = doubleval($el['pu']);
                    $item->qty = intval($el['qty']);
                    $item->amount = doubleval($el['amount']);

                    $item->save();
                    $invoice->items()->save($item);
                }else{
                    $item = Item::forceCreate([
                        'label' => $el['label'],
                        'pu' => doubleval($el['pu']),
                        'qty' => intval($el['qty']),
                        'amount' => doubleval($el['amount']),
                    ]);

                    $invoice->items()->save($item);
                }
            }

            //On affecte les taxes au devis
            $taxes = $request->selected_taxes;
            //On retire dabord toutes les taxes
            $invoice->taxes()->detach();
            //Ensuite on les ajoute
            foreach ($taxes as $el){
                $invoice->taxes()->attach($el['id']);
            }

        }catch (Exception $ex){
            return new JsonResponse(['message' => $ex->getMessage()], 400);
        }

        return new InvoiceResource($invoice);
    }

    public function patch(Request $request)
    {
        $invoice = Invoice::findOrFail($request->id);

        try{
            $data = $request->validate([
                'invoice_number' => ['required'],
                'title' => ['required'],
                'customer_id' => ['required'],
                'amount_et' => ['required'],
                'amount_discount' => ['required'],
                'amount' => ['required'],
                'discount' => ['required'],
                'amount_taxes' => ['required'],
            ]);

            $invoice->title = $request->title;
            $invoice->amount_et = $request->amount_et;
            $invoice->discount = $request->discount;
            $invoice->amount_discount = $request->amount_discount;
            $invoice->amount_taxes = $request->amount_taxes;
            $invoice->amount = $request->amount;
            $invoice->updated_at = new \DateTime();
            $invoice->expire_at = (new \DateTime())->add(new \DateInterval('P'.$this->informationApp->invoice_delay.'D'));
            $invoice->status = $request->status;

            $invoice->save();
        }catch (Exception $ex){
            return new JsonResponse(['message' => $ex->getMessage()], 400);
        }

        return new InvoiceResource($invoice);
    }

    public function printInvoice($invoice){
        $information = Functions::informations();
        $invoice = Invoice::findOrFail($invoice);
        $numberToWords = new NumberToWords();
        $numberTransformer = $numberToWords->getNumberTransformer('fr');
        $amountToWords =  $numberTransformer->toWords(ceil($invoice->amount));
        $pdf = PDF::loadView('admin.invoices.pdf_invoice', [
            'invoice' => $invoice,
            'amount_to_words' => $amountToWords,
            'information' => $information
        ]);

        // (Optional) Setup the paper size and orientation
        $pdf->setPaper('A4', 'portrait');

        return $pdf->stream('NST-I'.$invoice->invoice_number.'.pdf');

//        return $pdf->download($invoice->invoice_number.'.pdf');
    }

    public function sendEmail(Request $request){
        $information = Functions::informations();
        $invoice = Invoice::findOrFail($request->id);

        //On genere le pdf de la facture
        $numberToWords = new NumberToWords();
        $numberTransformer = $numberToWords->getNumberTransformer('fr');
        $amountToWords =  $numberTransformer->toWords(ceil($invoice->amount));
        $pdf = PDF::loadView('admin.invoices.pdf_invoice', [
            'invoice' => $invoice,
            'amount_to_words' => $amountToWords,
            'information' => $information
        ]);

        // (Optional) Setup the paper size and orientation
        $pdf->setPaper('A4', 'portrait');
        $filePath = public_path('uploads/documents/invoices/temp/').'NST-I'.$invoice->invoice_number.'.pdf';
        file_put_contents($filePath, $pdf->output());

        $to_name = $invoice->customer->company_name;
        $to_email = $invoice->customer->email;
        $data = array('invoice'=>$invoice);
        Mail::send('emails.invoice', $data, function($message) use ($to_name, $to_email, $information, $invoice, $filePath) {
            $message->to($to_email, $to_name)
                ->subject('Facture N° '.$invoice->invoice_number);
            $message->from($information->email,$information->social_reason);
            $message->attach($filePath);
        });

        return new InvoiceResource($invoice);
    }

    public function duplicateInvoice($invoice, Request $request){
        $oldInvoice = Invoice::find($invoice);
        $currentUser = Auth::user();

        $currentDate = new \DateTime();

        //On cree d'abord la facture
        $invoice = Invoice::forceCreate([
            'customer_id' => $oldInvoice->customer_id,
            'user_id' => $currentUser->id,
            'invoice_number' => Functions::generateInvoiceNumber(),
            'title' => $oldInvoice->title,
            'amount_et' => $oldInvoice->amount_et,
            'discount' => $oldInvoice->discount,
            'amount_discount' => $oldInvoice->amount_discount,
            'amount_taxes' => $oldInvoice->amount_taxes,
            'amount' => $oldInvoice->amount,
            'created_at' => $currentDate->format('Y-m-d'),
            'updated_at' => $currentDate,
            'expired' => false,
            'status' => 0
        ]);

        //On cree les items du devis et on attache au devis
        $items = $oldInvoice->items;
        foreach ($items as $el){
            $item = Item::forceCreate([
                'label' => $el['label'],
                'pu' => doubleval($el['pu']),
                'qty' => intval($el['qty']),
                'amount' => doubleval($el['amount']),
            ]);

            $invoice->items()->attach($item->id);
        }

        //On affecte les taxes au devis
        $taxes = $oldInvoice->taxes;
        foreach ($taxes as $el){
            $invoice->taxes()->attach($el['id']);
        }

        return redirect()->route('invoice.edit', ['invoice' => $invoice->id, 'action' => 'duplicate']);
    }

    public function addRecurrence(Request $request){
        $invoice = Invoice::findOrFail($request->invoice_id);
        $user = Auth::user();

        $data = $request->validate([
            'date' => ['required'],
            'period' => ['required'],
            'occurence' => ['required'],
        ]);

        $p = '1';
        switch ($request->period){
            case 'month':
                $p = 1;
                break;
            case 'trimester':
                $p = 3;
                break;
            case 'year':
                $p = 12;
                break;
        }

        $period = $p;
        $occurence = intval($request->occurence);

        $interval = ($p * $occurence) - $p;
        $start_date = new \DateTime($request->date);
        $end_date = (new \DateTime($request->date))->add(new \DateInterval('P'.$interval.'M'));

        //On cree l'occurence
        $recurrence = InvoiceRecurrence::forceCreate([
            'user_id' => $user->id,
            'invoice_id' => $invoice->id,
            'start_date' => $start_date,
            'end_date' => $end_date,
            'period' => $period,
            'occurence' => $occurence,
        ]);

        //On cree les dates d'occurence
        for($i=0; $i < $occurence; $i++){
            $interval = $i * $period;
            $occurenceDate = InvoiceRecurrenceDate::forceCreate([
                    'invoice_recurrence_id' => $recurrence->id,
                    'date' => (new \DateTime($request->date))->add(new \DateInterval('P'.$interval.'M'))
            ]);
        }

        return new InvoiceResource($invoice);

    }

    public function cancelRecurrence($recurrence){
        $recurrence = InvoiceRecurrence::find($recurrence);
        $invoice = $recurrence->invoice;

        if($recurrence->delete()){
            return new InvoiceResource($recurrence->invoice);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Invoice  $invoice
     * @return \Illuminate\Http\Response
     */
    public function destroy($invoice)
    {
        $invoice = Invoice::find($invoice);

        if($invoice->delete()){
            return new InvoiceResource($invoice);
        }
    }
}
