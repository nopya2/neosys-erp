<?php

namespace App\Http\Controllers;

use App\Group;
use App\User;
use App\Http\Resources\User as UserResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserController extends Controller
{

    public function home()
    {
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $users = User::where('name', 'LIKE', '%%')
            ->orderBy('name', 'asc')
            ->get();

        return view('admin.users.index', [
            'users' => $users,
            'page' => 'user',
            'sub_page' => 'user.list'
        ]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $users = User::where('name', 'like', '%' . $request->keyword . '%')
            ->orWhere('firstname', 'like', '%' . $request->keyword . '%')
            ->orWhere('username', 'like', '%' . $request->keyword . '%')
            ->orWhere('email', 'like', '%' . $request->keyword . '%')
            ->orderBy('name', 'asc')->paginate(10);;

        return UserResource::collection($users);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        return view('admin.users.create', [
            'page' => 'user',
            'sub_page' => 'user.create'
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
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $currentUser = Auth::user();
        $checkBox = true;

        if(!$request->has('status')){
            $checkBox = false;
        }

        $data = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'firstname' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255', 'unique:users'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8'],
            'role' => ['required'],
            'phonenumber' => [],
            'fonction' => []
        ]);

        User::forceCreate([
            'name' => $data['name'],
            'firstname' => $data['firstname'],
            'username' => $data['username'],
            'email' => $data['email'],
            'role' => $data['role'],
            'phonenumber' => $data['phonenumber'],
            'status' => $checkBox,
            'password' => Hash::make($data['password']),
            'api_token' => Str::random(80),
            'fonction' => $data['fonction']
        ]);

        return redirect('users')->with('success', 'Votre utilisateur a été créé!');
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

    public function selectUser($id)
    {
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $user = User::find($id);

        if($user)
            return new UserResource($user);
        else
            return new JsonResponse('error', 500);
    }

    public function changeStatus(Request $request)
    {
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $user = User::find($request->user);

        $user->status = $request->status;
        $user->save();

        return new UserResource($user);
    }

    public function ajaxResetPassword(Request $request){
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $user = User::find($request->user);
        $user->password = Hash::make($request->password);
        $user->save();

        return new UserResource($user);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($user)
    {
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $user = User::findOrFail($user);

        return view('admin.users.edit', [
            'user' => $user,
            'page' => 'user',
            'sub_page' => 'user.edit'
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $user)
    {
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $user = User::findOrFail($user);

        $checkBox = true;
        if(!$request->has('status')){
            $checkBox = false;
        }

        $data = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'firstname' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255', 'unique:users,username,'.$user->id],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email,'.$user->id],
            'role' => ['required'],
            'phonenumber' => [],
            'fonction' => []
        ]);

        $user->name = $request->get('name');
        $user->firstname = $request->get('firstname');
        $user->username = $request->get('username');
        $user->email = $request->get('email');
        $user->role = $request->get('role');
        $user->phonenumber = $request->get('phonenumber');
//        $user->api_token = Str::random(80);
        $user->status = $checkBox;
        $user->fonction = $request->fonction;
        $user->updated_at = new \DateTime();

        $user->save();
        return redirect('user/'. $user->id . '/edit')->with('success', 'Vos modifications ont été enregistrées!');
    }

    public function checkUsernameExists(Request $request, $username){
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $user = User::where('username', '=', $username)->first();

        if($user){
            if($request->has('id')){
                if($request->id == $user->id){
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
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $user = User::where('email', '=', $email)->first();

        if($user){
            if($request->has('id')){
                if($request->id == $user->id){
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

    public function apiLogin(Request $request){
        $user = User::where('username', '=', $request->login)
            ->orWhere('email', '=', $request->login)
            ->first();

        if($user->status == false)
            return new JsonResponse('error', 400);

        if( $user && Hash::check($request->password, $user->password)){
            $user->api_token = Str::random(80);
            $user->save();
            return new UserResource($user);
        }
        else
            return new JsonResponse('error', 400);

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($user)
    {
        if (!Gate::allows('isAdmin')) {
            abort(403, 'Désolé, vous ne pouvez pas executer cette action');
        }

        $user = User::find($user);

        if($user->delete()){
            return new UserResource($user);
        }
    }
}
