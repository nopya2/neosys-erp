@extends('admin.layout')

@section('header')
    @include('admin.include.header')
@endsection

@section('sidebar')
    @include('admin.include.sidebar')
@endsection

@section('footer')
    @include('admin.include.footer')
@endsection

@section('main_content')
    <div class="app-main__inner">
        <div class="app-page-title">
            <div class="page-title-wrapper">
                <div class="page-title-heading">
                    <div class="page-title-icon">
                        <i class="pe-7s-settings icon-gradient bg-mean-fruit">
                        </i>
                    </div>
                    <div>Paramètres
                        <div class="page-title-subheading">
                            Paramètres généraux
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{ route('home') }}">Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Paramètres</li>
                </ol>
            </nav>
        </div>

        <div class="row">
            <div class="col-md-6">
                <payment-methods-list></payment-methods-list>
            </div>

            <div class="col-md-6">
                <emails :email_models="{{ $email_models }}"></emails>
            </div>
        </div>


    </div>

@endsection

@push('custom_scripts')

@endpush