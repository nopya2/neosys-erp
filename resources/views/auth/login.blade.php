<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>NEOSYS ERP | Connexion</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <link href="{{ asset('theme/architectui-html-free/main.css') }}" rel="stylesheet"></head>
</head>
<body class="hold-transition login-page" style="background: #3C4D76">
<div class="login-box" id="app">
    {{--<div class="login-logo">--}}
        {{--<a href="#"><b>Compta</b>REPORT</a>--}}
    {{--</div>--}}
    <!-- /.login-logo -->
    <div class="row">
        <div class="col-md-12 text-center p-5 mt-5">

        </div>
    </div>
    <login-component></login-component>
</div>
<script src="{{ asset('js/app.js') }}"></script>


</body>
</html>
