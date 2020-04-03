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
                        <i class="pe-7s-info icon-gradient bg-mean-fruit">
                        </i>
                    </div>
                    <div>Informations Générales
                        <div class="page-title-subheading">
                            Informations de l'entreprise, informations bancaires, configuration de l'entete et pied de page
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{ route('home') }}">Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Informations Générales</li>
                </ol>
            </nav>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12">
                <information-component :information_data="{{ $information }}"></information-component>
            </div>
        </div>


    </div>

@endsection

@push('custom_scripts')

@endpush