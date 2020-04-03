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
                        <i class="fa fa-address-book icon-gradient bg-mean-fruit">
                        </i>
                    </div>
                    <div>Clients - Mettre à jour
                        <div class="page-title-subheading">
                            Mise à jour du client
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12">
                <div class="main-card mb-3 card">
                    <div class="card-body">
                        @if(session()->get('success'))
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                <strong>Succès!</strong> {{ session()->get('success') }}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                            </div>
                        @endif
                        <customer-form-edit :customer_id="'{{ $customer->id }}'"></customer-form-edit>
                    </div>
                </div>
            </div>
        </div>


    </div>

@endsection

@push('custom_scripts')

@endpush