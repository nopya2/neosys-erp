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
                    <div>Commande -
                        @if($action === 'edit')
                            Modifier [{{ $purchase_order->purchase_order_number }}] - <small>{{ $purchase_order->updated_at->format('d/m/Y') }}</small>
                            <div class="page-title-subheading">
                                Edition de la commande
                            </div>
                        @elseif($action === 'reedit')
                            Rééditer [{{ $purchase_order->purchase_order_number }}] - <small>{{ $purchase_order->updated_at->format('d/m/Y') }}</small>
                            <div class="page-title-subheading">
                                Réédition de la commande
                            </div>
                        @elseif($action === 'show')
                            Détails [{{ $purchase_order->purchase_order_number }}] - <small>{{ $purchase_order->updated_at->format('d/m/Y') }}</small>
                            <div class="page-title-subheading">
                                Détails de la commande. Ce commande ne peut plus être modifiée ou supprimée
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
                    <li class="breadcrumb-item"><a href="{{ route('purchase_order.index') }}">Commandes</a></li>
                    <li class="active breadcrumb-item" aria-current="page">Modifier commande [{{ $purchase_order->purchase_order_number }}]</li>
                </ol>
            </nav>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">
                        {{--{{ $purchase_order }}--}}
                        <purchase-order-edit-form :customers="{{ $customers }}" :taxes="{{ $taxes }}" :old_purchase_order="{{ $purchase_order }}"
                            :purchase_order_taxes="{{ $purchase_order->taxes }}" :purchase_order_items="{{ $purchase_order->items }}"
                            :action="'{{$action}}'"></purchase-order-edit-form>
                    </div>
                </div>
            </div>
        </div>


    </div>

@endsection

@push('custom_scripts')

@endpush