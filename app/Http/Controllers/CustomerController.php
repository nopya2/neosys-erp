<?php

namespace App\Http\Controllers;

use App\Account;
use App\Customer;
use App\Http\Resources\Customer as CustomerResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CustomerController extends Controller
{
    public function home()
    {
        return view('admin.customers.index', [
            'page' => 'customer',
            'sub_page' => 'customer.list'
        ]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $customers = DB::table('customers')
            ->join('users', 'customers.manager_id', '=', 'users.id')
            ->select('customers.*', 'users.name as manager')
            ->where('company_name', 'LIKE', '%' . $request->keyword . '%')
            ->orderBy('company_name', 'asc')
            ->paginate(10);


        return new JsonResponse($customers);
    }

    public function select(Request $request)
    {
        $customers = Customer::where('company_name', 'LIKE', '%'.$request->search.'%')
            ->orderBy('company_name', 'asc')
            ->paginate(20);

        return CustomerResource::collection($customers);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $action = '';
        if($request->has('action'))
            $action = $request->action;

        return view('admin.customers.create', [
            'page' => 'customer',
            'sub_page' => 'customer.create',
            'action' => $action
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
        $userId = Auth::user()->id;

        $data = $request->validate([
            'company_name' => ['required', 'string', 'max:255', 'unique:customers'],
            'phonenumber' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:customers'],
            'activity' => ['required'],
            'country' => ['required'],
            'city' => ['required'],
            'address' => ['required'],
            'website' => [],
            'bp' => [''],
        ]);

        $customer = Customer::forceCreate([
            'manager_id' => $userId,
            'company_name' => $data['company_name'],
            'phonenumber' => $data['phonenumber'],
            'email' => $data['email'],
            'activity' => $data['activity'],
            'country' => $data['country'],
            'city' => $data['city'],
            'address' => $data['address'],
            'website' => $data['website'],
            'bp' => $data['bp']
        ]);

        if($request->has('action'))
            return new CustomerResource($customer);

        return redirect('customers')->with('success', 'Votre client a été créé!');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    public function selectCustomer($id)
    {
        $customer = Customer::find($id);

        if($customer)
            return new CustomerResource($customer);
        else
            return new JsonResponse();
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($customer)
    {
        $customer = Customer::findOrFail($customer);

        return view('admin.customers.edit', [
            'customer' => $customer,
            'page' => 'customer',
            'sub_page' => 'customer.edit'
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $customer)
    {
        $customer = Customer::findOrFail($customer);

        $data = $request->validate([
            'company_name' => ['required', 'string', 'max:255', 'unique:customers,company_name,'.$customer->id],
            'phonenumber' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:customers,email,'.$customer->id],
            'activity' => ['required'],
            'country' => ['required'],
            'city' => ['required'],
            'address' => ['required'],
            'website' => [],
            'bp' => [''],
        ]);

        $customer->company_name = $request->get('company_name');
        $customer->phonenumber = $request->get('phonenumber');
        $customer->email = $request->get('email');
        $customer->activity = $request->get('activity');
        $customer->country = $request->get('country');
        $customer->city = $request->get('city');
        $customer->address = $request->get('address');
        $customer->website = $request->get('website');
        $customer->bp = $request->get('bp');

        $customer->save();

        return redirect('customer/'. $customer->id . '/edit')->with('success', 'Vos modifications ont été enregistrées!');
    }

    public function checkCompanyNameExists(Request $request, $customer){
        $customer = Customer::where('company_name', '=', $customer)->first();

        if($customer){
            if($request->has('id')){
                if($request->id == $customer->id){
                    $exist = false;
                }else{
                    $exist = true;
                }

            }else{
                $exist = true;
            }
        }
        else
            $exist = false;

        return new JsonResponse(!$exist);
    }

    public function checkEmailExists(Request $request, $email){
        $customer = Customer::where('email', '=', $email)->first();

        if($customer){
            if($request->has('id')){
                if($request->id == $customer->id){
                    $exist = false;
                }else{
                    $exist = true;
                }
            }else{
                $exist = true;
            }
        }
        else
            $exist = false;

        return new JsonResponse(!$exist);
    }

    public function generateCustomerNumber(){

        return new JsonResponse(0);
    }

    public function selectCustomersByRole(){
        $currentUser = Auth::user();

        switch ($currentUser->role->slug) {
            case 'super-admin':
                $customers = Customer::all();
                break;
            case 'admin':
                $customers = Customer::all();
                break;
            case 'manager':
                $customers = Customer::all();
                break;
            case 'commercial':
                $customers = Customer::where('manager_id', '=', $currentUser->id)
                    ->get();
                break;
            case 'customer-admin':
                $customers = Customer::where('manager_id', '=', '-1')
                    ->get();
                break;
            case 'customer-user':
                $customers = Customer::where('manager_id', '=', '-1')
                    ->get();
                break;
            default:
                $customers = Customer::where('manager_id', '=', '-1')
                    ->get();
                break;
        }

        //Return collection of groups as a resource
        return CustomerResource::collection($customers);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($customer)
    {
        $customer = Customer::find($customer);

        if($customer->delete()){
            return new CustomerResource($customer);
        }
    }
}
