<?php

namespace App\Http\Controllers;

use App\Information;
use App\Invoice;
use App\Item;
use App\PurchaseOrder;
use App\Quote;
use App\Http\Resources\Quote as QuoteResource;
use App\Customer;
use App\Providers\Functions;
use App\Tax;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use PDF;
use NumberToWords\NumberToWords;

class QuoteController extends Controller
{
    public function home()
    {
        return view('admin.quotes.index', [
            'page' => 'quote',
            'sub_page' => 'quote.list'
        ]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $quotes = Quote::where('quote_number', 'LIKE', '%' . $request->keyword . '%')
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
                    //Devis expire
                    $quotes = $quotes->filter(function ($quote) {
                        return $quote->expired == true;
                    });
                    break;
                case '2':
                    //Devis en cours
                    $quotes = $quotes->filter(function ($quote) {
                        return $quote->expired != true & $quote->is_billed != true;
                    });
                    break;
                case '3':
                    //Devis facture
                    $quotes = $quotes->filter(function ($quote) {
                        return $quote->is_billed == true;
                    });
                    break;
            }
        }


        return QuoteResource::collection($quotes)->paginate(10);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $customers = Customer::where('company_name', 'LIKE', '%%')
            ->orderBy('company_name', 'asc')
            ->get();

        $taxes = Tax::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->get();

        $quoteNumber = Functions::generateQuoteNumber();

        return view('admin.quotes.create', [
            'page' => 'quote',
            'sub_page' => 'quote.list',
            'customers' => $customers,
            'taxes' => $taxes,
            'quote_number' => $quoteNumber
        ]);
    }


    public function store(Request $request)
    {
        $currentUser = Auth::user();

        $data = $request->validate([
            'quote_number' => ['required'],
            'title' => ['required'],
            'customer_id' => ['required'],
            'amount_et' => ['required'],
            'amount_discount' => ['required'],
            'amount' => ['required'],
            'discount' => ['required'],
            'amount_taxes' => ['required'],
        ]);

        $currentDate = new \DateTime();
        $expireAt = $currentDate->add(new \DateInterval('P30D'));

        //On cree d'abord le devis
        $quote = Quote::forceCreate([
            'customer_id' => $data['customer_id'],
            'user_id' => $currentUser->id,
            'quote_number' => $data['quote_number'],
            'title' => $data['title'],
            'amount_et' => $data['amount_et'],
            'discount' => $data['discount'],
            'amount_discount' => $data['amount_discount'],
            'amount_taxes' => $data['amount_taxes'],
            'amount' => $data['amount'],
            'created_at' => new \DateTime(),
            'updated_at' => new \DateTime(),
            'expire_at' => $expireAt,
            'expired' => false,
        ]);

        //On cree les items du devis et on attache au devis
        $items = $request->items;
        foreach ($items as $el){
            $item = Item::forceCreate([
                'label' => $el['label'],
                'pu' => doubleval($el['pu']),
                'qty' => intval($el['qty']),
                'amount' => doubleval($el['amount']),
            ]);

            $quote->items()->attach($item->id);
        }

        //On affecte les taxes au devis
        $taxes = $request->selected_taxes;
        foreach ($taxes as $el){
            $quote->taxes()->attach($el['id']);
        }

        return new QuoteResource($quote);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Quote  $quote
     * @return \Illuminate\Http\Response
     */
    public function show($quote)
    {
        $quote = Quote::find($quote);

        return new QuoteResource($quote);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Quote  $quote
     * @return \Illuminate\Http\Response
     */
    public function edit($quote, Request $request)
    {
        $action = $request->action;
        $quote = Quote::findOrFail($quote);

        $customers = Customer::where('company_name', 'LIKE', '%%')
            ->orderBy('company_name', 'asc')
            ->get();

        $taxes = Tax::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->get();

        return view('admin.quotes.edit', [
            'quote' => $quote,
            'page' => 'quote',
            'sub_page' => 'quote.list',
            'customers' => $customers,
            'taxes' => $taxes,
            'action' => $action
        ]);
    }


    public function update(Request $request)
    {
        $quote = Quote::findOrFail($request->id);

        $data = $request->validate([
            'quote_number' => ['required'],
            'title' => ['required'],
            'customer_id' => ['required'],
            'amount_et' => ['required'],
            'amount_discount' => ['required'],
            'amount' => ['required'],
            'discount' => ['required'],
            'amount_taxes' => ['required'],
        ]);

        $currentDate = new \DateTime();

        $quote->title = $request->title;
        $quote->amount_et = $request->amount_et;
        $quote->discount = $request->discount;
        $quote->amount_discount = $request->amount_discount;
        $quote->amount_taxes = $request->amount_taxes;
        $quote->amount = $request->amount;
        $quote->updated_at = $currentDate;

        if($request->action === 'reedit'){
            $expireAt = $currentDate->add(new \DateInterval('P30D'));
            $quote->expire_at = $expireAt;
        }

        $quote->save();

        //On detache d'abord tous les items
        $quote->items()->detach();
        //On cree les nouveaux items du devis et on attache au devis
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
                $quote->items()->attach($item->id);
            }else{
                $item = Item::forceCreate([
                    'label' => $el['label'],
                    'pu' => doubleval($el['pu']),
                    'qty' => intval($el['qty']),
                    'amount' => doubleval($el['amount']),
                ]);

                $quote->items()->attach($item->id);
            }
        }

        //On affecte les taxes au devis
        $taxes = $request->selected_taxes;
        //On retire dabord toutes les taxes
        $quote->taxes()->detach();
        //Ensuite on les ajoute
        foreach ($taxes as $el){
            $quote->taxes()->attach($el['id']);
        }

        return new QuoteResource($quote);
    }

    public function printQuote($quote){
        $information = Information::find(1);
        $quote = Quote::findOrFail($quote);
        $numberToWords = new NumberToWords();
        $numberTransformer = $numberToWords->getNumberTransformer('fr');
        $amountToWords =  $numberTransformer->toWords(ceil($quote->amount));
        $pdf = PDF::loadView('admin.quotes.pdf_quote', [
            'quote' => $quote,
            'amount_to_words' => $amountToWords,
            'information' => $information
        ]);

        return $pdf->stream('NST-Q'.$quote->quote_number.'.pdf');

//        return $pdf->download($quote->quote_number.'.pdf');
    }

    public function billQuote($quote, Request $request){
        $quote = Quote::find($quote);

        $currentUser = Auth::user();

        $currentDate = new \DateTime();

        $invoice = Invoice::forceCreate([
            'customer_id' => $quote->customer_id,
            'user_id' => $currentUser->id,
            'invoice_number' => Functions::generateInvoiceNumber(),
            'title' => $quote->title,
            'amount_et' => $quote->amount_et,
            'discount' => $quote->discount,
            'amount_discount' => $quote->amount_discount,
            'amount_taxes' => $quote->amount_taxes,
            'amount' => $quote->amount,
            'created_at' => $currentDate->format('Y-m-d'),
            'updated_at' => $currentDate,
//            'expire_at' => $expireAt,
            'expired' => false,
            'status' => 0,
            'quote_id' => $quote->id
        ]);

        //On cree les items de la facture et on attache a la facture
        $items = $quote->items;
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
        $taxes = $quote->taxes;
        foreach ($taxes as $el){
            $invoice->taxes()->attach($el['id']);
        }

        $quote->is_billed = true;
        $quote->save();

        return redirect()->route('invoice.edit', ['invoice' => $invoice->id, 'action' => 'bill']);
    }

    public function duplicateQuote($quote, Request $request){
        $oldQuote = Quote::find($quote);

        $currentUser = Auth::user();

        $currentDate = new \DateTime();

        //On cree d'abord le devis
        $quote = Quote::forceCreate([
            'customer_id' => $oldQuote->customer_id,
            'user_id' => $currentUser->id,
            'quote_number' => Functions::generateQuoteNumber(),
            'title' => $oldQuote->title,
            'amount_et' => $oldQuote->amount_et,
            'discount' => $oldQuote->discount,
            'amount_discount' => $oldQuote->amount_discount,
            'amount_taxes' => $oldQuote->amount_taxes,
            'amount' => $oldQuote->amount,
            'created_at' => $currentDate->format('Y-m-d'),
            'updated_at' => $currentDate,
//            'expire_at' => $expireAt,
            'expired' => false,
            'is_billed' => false
        ]);

        //On cree les items du devis et on attache au devis
        $items = $oldQuote->items;
        foreach ($items as $el){
            $item = Item::forceCreate([
                'label' => $el['label'],
                'pu' => doubleval($el['pu']),
                'qty' => intval($el['qty']),
                'amount' => doubleval($el['amount']),
            ]);

            $quote->items()->attach($item->id);
        }

        //On affecte les taxes au devis
        $taxes = $oldQuote->taxes;
        foreach ($taxes as $el){
            $quote->taxes()->attach($el['id']);
        }

        return redirect()->route('quote.edit', ['quote' => $quote->id, 'action' => 'duplicate']);
    }

    public function sendEmail(Request $request){
        $information = Functions::informations();
        $quote = Quote::findOrFail($request->id);

        //On genere le pdf du devis
        $numberToWords = new NumberToWords();
        $numberTransformer = $numberToWords->getNumberTransformer('fr');
        $amountToWords =  $numberTransformer->toWords(ceil($quote->amount));
        $pdf = PDF::loadView('admin.quotes.pdf_quote', [
            'quote' => $quote,
            'amount_to_words' => $amountToWords,
            'information' => $information
        ]);

        // (Optional) Setup the paper size and orientation
        $pdf->setPaper('A4', 'portrait');
        $filePath = public_path('uploads/documents/quotes/temp/').'NST-Q'.$quote->quote_number.'.pdf';
        file_put_contents($filePath, $pdf->output());

        $to_name = $quote->customer->company_name;
        $to_email = $quote->customer->email;
        $data = array('quote'=>$quote);
        Mail::send('emails.quote', $data, function($message) use ($to_name, $to_email, $information, $quote, $filePath) {
            $message->to($to_email, $to_name)
                ->subject('Devis N° '.$quote->quote_number);
            $message->from($information->email,$information->social_reason);
            $message->attach($filePath);
        });

        return new QuoteResource($quote);
    }

    public function printPurchaseOrder($quote){
        $information = Information::find(1);
        $quote = Quote::findOrFail($quote);
        //Creation du bon de livraison
        //On verifie si ce numero de bon de commande a deja ete enregistre
        //SI NON on genere un nouveau bon de commande
        //SI OUI on affiche juste le PDF
        $purchaseOrder = PurchaseOrder::where('purchase_order_number', $quote->quote_number)->first();
        if(!$purchaseOrder){
            $purchaseOrder = PurchaseOrder::forceCreate([
                'quote_id' => $quote->id,
                'user_id' => Auth::user()->id,
                'purchase_order_number' => $quote->quote_number
            ]);
        }

        $numberToWords = new NumberToWords();
        $numberTransformer = $numberToWords->getNumberTransformer('fr');
        $amountToWords =  $numberTransformer->toWords(ceil($quote->amount));
        $pdf = PDF::loadView('admin.quotes.pdf_purchase_order', [
            'quote' => $quote,
            'amount_to_words' => $amountToWords,
            'information' => $information
        ]);

        return $pdf->stream('NST-Q'.$quote->quote_number.'.pdf');

//        return $pdf->download($quote->quote_number.'.pdf');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Quote  $quote
     * @return \Illuminate\Http\Response
     */
    public function destroy($quote)
    {
        $quote = Quote::find($quote);

        if($quote->delete()){
            return new QuoteResource($quote);
        }
    }
}
