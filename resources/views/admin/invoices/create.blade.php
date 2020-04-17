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
                    <div>Facture -
                        @if($action === 'duplicate') Dupliquer
                        @else
                            Nouvelle
                        @endif

                        @if($action !== 'duplicate')
                            <div class="page-title-subheading">
                                Edition d'une nouvelle facture
                            </div>
                        @endif
                        @if($action === 'duplicate')
                            <div class="page-title-subheading">
                                Duplicata d'une facture
                            </div>
                        @endif

                    </div>
                </div>
            </div>
        </div>

        <div>
            <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{ route('home') }}">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="{{ route('invoice.index') }}">Factures</a></li>
                    @if($action !== 'duplicate')
                        <li class="active breadcrumb-item" aria-current="page">Nouvellle</li>
                    @endif
                    @if($action === 'duplicate')
                        <li class="active breadcrumb-item" aria-current="page">Dupliquer</li>
                    @endif
                </ol>
            </nav>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">
                        <invoice-form :taxes="{{ $taxes }}" :payment_methods="{{ $payment_methods }}" :action="'{{ $action }}'"
                            :invoice_info="{{ $invoice }}" :invoice_items="{{ $invoice->items }}" :invoice_taxes="{{ $invoice->taxes }}"
                            :list_customers="{{ $customers }}"></invoice-form>
                    </div>
                </div>
            </div>
        </div>


    </div>

@endsection

@push('custom_scripts')

@endpush