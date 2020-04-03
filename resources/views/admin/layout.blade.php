<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta http-equiv="Content-Language" content="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Analytics Dashboard - This is an example dashboard created using build-in elements and components.</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="This is an example dashboard created using build-in elements and components.">
    <meta name="msapplication-tap-highlight" content="no">
    <!--
    =========================================================
    * ArchitectUI HTML Theme Dashboard - v1.0.0
    =========================================================
    * Product Page: https://dashboardpack.com
    * Copyright 2019 DashboardPack (https://dashboardpack.com)
    * Licensed under MIT (https://github.com/DashboardPack/architectui-html-theme-free/blob/master/LICENSE)
    =========================================================
    * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    -->
    {{--<link rel="stylesheet" type="text/css" href="{{ asset('library/DataTables/datatables.css') }}">--}}
    <link rel="stylesheet" type="text/css" href="{{ asset('library/select2-4.0.13/dist/css/select2.min.css') }}">
    <link href="{{ asset('theme/architectui-html-free/main.css') }}" rel="stylesheet">
    <link href="{{ asset('css/custom.css') }}" rel="stylesheet" type="text/css">
</head>
<body>
<div class="app-container app-theme-white body-tabs-shadow fixed-sidebar fixed-header" id="app">
    @yield('header')

    <div class="app-main">

        @yield('sidebar')

        @yield('app_main')


        <div class="app-main__outer">

            @yield('main_content')

            @yield('footer')
        </div>
        {{--<script src="http://maps.google.com/maps/api/js?sensor=true"></script>--}}
    </div>


</div>


<script src="{{ asset('js/jquery-3.4.1.min.js') }}"></script>
{{--<script src="{{ asset('js/popper.min.js') }}"></script>--}}
{{--<script src="{{ asset('library/bootstrap/js/bootstrap.min.js') }}"></script>--}}
{{--<script type="text/javascript" charset="utf8" src="{{ asset('library/DataTables/datatables.js') }}"></script>--}}
<script type="text/javascript" charset="utf8" src="{{ asset('library/select2-4.0.13/dist/js/select2.min.js') }}"></script>
<script type="text/javascript" src="{{ asset('theme/architectui-html-free/assets/scripts/main.js') }}"></script>
<script type="text/javascript" src="{{ asset('js/custom.js') }}"></script>
@stack('custom_scripts')
<script src="{{ asset('js/app.js') }}"></script>
</body>
</html>
