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
                        <i class="fa fa-calculator icon-gradient bg-mean-fruit">
                        </i>
                    </div>
                    <div>Devis - Nouveau
                        <div class="page-title-subheading">
                            Edition d'un nouveau devis
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{ route('home') }}">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="{{ route('quote.index') }}">Devis</a></li>
                    <li class="active breadcrumb-item" aria-current="page">Nouveau devis</li>
                </ol>
            </nav>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">
                        <quote-form :taxes="{{ $taxes }}"></quote-form>
                    </div>
                </div>
            </div>
        </div>


    </div>

@endsection

@push('custom_scripts')

@endpush