<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ParameterController extends Controller
{
    public function index()
    {
        return view('admin.parameters', [
            'page' => 'parameters',
            'sub_page' => 'parameters.index'
        ]);
    }
}
