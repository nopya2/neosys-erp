<?php

namespace App\Http\Controllers;

use App\Customer;
use App\Information;
use App\Item;
use App\Providers\Functions;
use App\PurchaseOrder;
use App\Http\Resources\PurchaseOrder as PurchaseOrderResource;
use App\Tax;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\View;

class PurchaseOrderController extends Controller
{
    protected $appInformation;
    protected $authUser;

    public function __construct()
    {
        $this->appInformation = Information::find(1);
        $this->authUser = Auth::user();
        View::share('app_information', $this->appInformation);
        View::share('auth_user', $this->authUser);
    }

    public function home()
    {
        return view('admin.purchase_orders.index', [
            'page' => 'purchase_order',
            'sub_page' => 'purchase_order.list'
        ]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $purchaseOrders = PurchaseOrder::where('status', 'LIKE', '%'.$request->status.'%')
            ->where(function ($query) use ($request){
                $query
                    ->whereHas('customer', function ($query) use ($request){
                        $query
                            ->where('company_name', 'LIKE', '%' . $request->keyword . '%');
                    })
                    ->orWhere('title', 'LIKE', '%' . $request->keyword . '%')
                    ->orWhere('purchase_order_number', 'LIKE', '%' . $request->keyword . '%');
            })
            ->orderBy('id', 'desc')
            ->get();


        return PurchaseOrderResource::collection($purchaseOrders)->paginate(10);
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

        return view('admin.purchase_orders.create', [
            'page' => 'purchase_order',
            'sub_page' => 'purchase_order.list',
            'taxes' => $taxes,
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => ['required'],
            'customer_id' => ['required'],
            'amount_et' => ['required'],
            'amount_discount' => ['required'],
            'amount' => ['required'],
            'discount' => ['required'],
            'amount_taxes' => ['required'],
        ]);

        $currentDate = new \DateTime();
        $expireAt = $currentDate->add(new \DateInterval('P'.$this->appInformation->purchase_order_delay.'D'));

        try {
            //On cree d'abord la commande
            $purchaseOrder = PurchaseOrder::forceCreate([
                'customer_id' => $data['customer_id'],
                'user_id' => Auth::user()->id,
                'purchase_order_number' => Functions::generatePurchaseOrderNumber(),
                'title' => $data['title'],
                'amount_et' => $data['amount_et'],
                'discount' => $data['discount'],
                'amount_discount' => $data['amount_discount'],
                'amount_taxes' => $data['amount_taxes'],
                'amount' => $data['amount'],
                'created_at' => new \DateTime(),
                'updated_at' => new \DateTime(),
                'expire_at' => $expireAt,
            ]);

            //On cree les items de la commande et on attache a la commande
            $items = $request->items;
            foreach ($items as $el){
                $item = Item::forceCreate([
                    'label' => $el['label'],
                    'pu' => doubleval($el['pu']),
                    'qty' => intval($el['qty']),
                    'amount' => doubleval($el['amount']),
                ]);

                $purchaseOrder->items()->save($item);
            }

            //On affecte les taxes a la commande
            $taxes = $request->selected_taxes;
            foreach ($taxes as $el){
                $purchaseOrder->taxes()->attach($el['id']);
            }
        }catch (Exception $e){
            return new JsonResponse(['message' => $e->getMessage()], 400);
        }

        return new PurchaseOrderResource($purchaseOrder);
    }


    public function show($purchaseOrder)
    {
        $purchaseOrder = PurchaseOrder::find($purchaseOrder);

        return new PurchaseOrderResource($purchaseOrder);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\PurchaseOrder  $purchaseOrder
     * @return \Illuminate\Http\Response
     */
    public function edit($purchaseOrder, Request $request)
    {
        $action = $request->action;
        $purchaseOrder = PurchaseOrder::findOrFail($purchaseOrder);

        $customers = Customer::where('company_name', 'LIKE', '%%')
            ->orderBy('company_name', 'asc')
            ->get();

        $taxes = Tax::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->get();

        return view('admin.purchase_orders.edit', [
            'purchase_order' => $purchaseOrder,
            'page' => 'purchase_order',
            'sub_page' => 'purchase_order.list',
            'customers' => $customers,
            'taxes' => $taxes,
            'action' => $action
        ]);
    }

    public function update($purchaseOrder, Request $request)
    {
        $purchaseOrder = PurchaseOrder::findOrFail($request->id);
        if($purchaseOrder->status === 'billed'){
            return new JsonResponse(['message'=>'Action non permise'], 400);
        }

        $data = $request->validate([
            'purchase_order_number' => ['required'],
            'title' => ['required'],
            'customer_id' => ['required'],
            'amount_et' => ['required'],
            'amount_discount' => ['required'],
            'amount' => ['required'],
            'discount' => ['required'],
            'amount_taxes' => ['required'],
        ]);

        $currentDate = new \DateTime();

        $purchaseOrder->title = $request->title;
        $purchaseOrder->amount_et = $request->amount_et;
        $purchaseOrder->discount = $request->discount;
        $purchaseOrder->amount_discount = $request->amount_discount;
        $purchaseOrder->amount_taxes = $request->amount_taxes;
        $purchaseOrder->amount = $request->amount;
        $purchaseOrder->updated_at = $currentDate;
//        $expireAt = $currentDate->add(new \DateInterval('P'.$this->app_information->quote_delay.'D'));
//        $purchaseOrder->expire_at = $expireAt;
//        $purchaseOrder->status = 'in_progress';

        $purchaseOrder->save();

        //On detache d'abord tous les items
        $purchaseOrder->items()->delete();
        //On cree les nouveaux items de la commande et on attache a la commande
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
                $purchaseOrder->items()->attach($item->id);
            }else{
                $item = Item::forceCreate([
                    'label' => $el['label'],
                    'pu' => doubleval($el['pu']),
                    'qty' => intval($el['qty']),
                    'amount' => doubleval($el['amount']),
                ]);

                $purchaseOrder->items()->save($item);
            }
        }

        //On affecte les taxes au devis
        $taxes = $request->selected_taxes;
        //On retire dabord toutes les taxes
        $purchaseOrder->taxes()->detach();
        //Ensuite on les ajoute
        foreach ($taxes as $el){
            $purchaseOrder->taxes()->attach($el['id']);
        }

        return new PurchaseOrderResource($purchaseOrder);
    }

    public function changeStatus($purchaseOrder, Request $request){

        $purchaseOrder = PurchaseOrder::find($purchaseOrder);

        $purchaseOrder->status = $request->status;
        $purchaseOrder->updated_at = new \DateTime();
        $purchaseOrder->save();

        return new PurchaseOrderResource($purchaseOrder);
    }

    public function duplicate($purchaseOrder, Request $request){
        $purchaseOrder = PurchaseOrder::find($purchaseOrder);

        $taxes = Tax::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->get();

        return view('admin.purchase_orders.duplicate', [
            'purchase_order' => $purchaseOrder,
            'page' => 'purchase_order',
            'sub_page' => 'purchase_order.list',
            'taxes' => $taxes,
        ]);
    }

    public function updateStatus(Request $request){
        $purchaseOrders = PurchaseOrder::where('status', 'validated')->get();
        $now = new \DateTime();
        foreach ($purchaseOrders as $purchaseOrder){
            if($now > $purchaseOrder->expire_at){
                $purchaseOrder->status = 'canceled';
                $purchaseOrder->updated_at = new \DateTime();
                $purchaseOrder->save();
            }
        }

        return 1;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\PurchaseOrder  $purchaseOrder
     * @return \Illuminate\Http\Response
     */
    public function destroy($purchaseOrder)
    {
        $purchaseOrder = PurchaseOrder::find($purchaseOrder);
        if($purchaseOrder->status !== 'draft'){
            return new JsonResponse(['message'=>'Action non permise'], 400);
        }

        if($purchaseOrder->delete()){
            return new PurchaseOrderResource($purchaseOrder);
        }
    }
}
