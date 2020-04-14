<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Route::middleware('auth:api')->get('/user', function (Request $request) {
//    return $request->user();
//});

Route::post('/oauth', 'UserController@apiLogin');

//Modifier les informations
Route::middleware('auth:api')->put('information', 'InformationController@update');
Route::middleware('auth:api')->post('information', 'InformationController@updatePicture');

//List users
Route::middleware('auth:api')->get('users', 'UserController@index');
//Change user status
Route::middleware('auth:api')->post('user/change-status', 'UserController@changeStatus');
//Reset user password
Route::middleware('auth:api')->post('user/reset-password', 'UserController@ajaxResetPassword');
//Check if username exists
Route::middleware('auth:api')->get('user/unique-username/{username}', 'UserController@checkUsernameExists');
//Check if email exists
Route::middleware('auth:api')->get('user/unique-email/{email}', 'UserController@checkEmailExists');
//Select user
Route::middleware('auth:api')->get('user/{id}', 'UserController@selectUser');
//Delete user
Route::middleware('auth:api')->delete('user/{user}', 'UserController@destroy');

//List engagements
Route::middleware('auth:api')->get('engagements', 'EngagementController@index');
//Selectionner un engagement
Route::middleware('auth:api')->get('engagements/{engagement}', 'EngagementController@ajaxSelectSingle');
//Import fichier engagements
Route::middleware('auth:api')->post('engagements/import', 'EngagementController@import');
//Select engagements par statut
Route::middleware('auth:api')->get('engagements/ajax/engagements-par-statut', 'EngagementController@engagementsParStatut');
//nbre engagements par annee
Route::middleware('auth:api')->get('engagements/ajax/engagements-par-annee', 'EngagementController@engagementsParAnnee');
//montant total par annee
Route::middleware('auth:api')->get('engagements/ajax/montants-par-annee', 'EngagementController@montantParAnnee');
//Selection des engagements par filtre multi criteres
Route::middleware('auth:api')->get('search', 'EngagementController@engagementsByMutlicriteria');


//Selection des echelons par le numero d'engagement
Route::middleware('auth:api')->get('echelons/select-by-engagement-number', 'EchelonController@selectByEngagementNumber');
//Ajouter un paiement
Route::middleware('auth:api')->post('echelon', 'EchelonController@store');

/****** Echelons ******/
//List echelons
Route::middleware('auth:api')->get('echelons', 'EchelonController@index');

/****** Providers ******/
//List providers
Route::middleware('auth:api')->get('providers', 'ProviderController@index');
//On charge les informations du fournisseur
Route::middleware('auth:api')->get('providers/details', 'ProviderController@loadData');
//On charge les engagements du fournisseur
Route::middleware('auth:api')->get('provider/engagements', 'ProviderController@loadEngagements');
//On charge les echelons du fournisseur
Route::middleware('auth:api')->get('provider/echelons', 'ProviderController@loadEchelons');

//List customers
Route::middleware('auth:api')->get('customers', 'CustomerController@index');
//Select 20 csutomers
Route::middleware('auth:api')->get('customers/select', 'CustomerController@select');
//Select customers by user role
Route::middleware('auth:api')->get('customers/customers-by-user-role', 'CustomerController@selectCustomersByRole');
//Check if company name exists
Route::middleware('auth:api')->get('customer/unique-name/{customer}', 'CustomerController@checkCompanyNameExists');
//Check if email exists
Route::middleware('auth:api')->get('customer/unique-email/{customer}', 'CustomerController@checkEmailExists');
//Check generer numero client
Route::middleware('auth:api')->get('customer/generate-customer-number', 'CustomerController@generateCustomerNumber');
//Select single customer
Route::middleware('auth:api')->get('customer/{id}', 'CustomerController@selectCustomer');
//Delete customer
Route::middleware('auth:api')->delete('customer/{customer}', 'CustomerController@destroy');
//Add customer
Route::middleware('auth:api')->post('customer', 'CustomerController@store');

//List quotes
Route::middleware('auth:api')->get('quotes', 'QuoteController@index');
//Creer un devis
Route::middleware('auth:api')->post('quote', 'QuoteController@store');
//Modifier un devis
Route::middleware('auth:api')->put('quote', 'QuoteController@update');
//Select a quote
Route::middleware('auth:api')->get('quote/{quote}', 'QuoteController@show');
//Delete quote
Route::middleware('auth:api')->delete('quote/{quote}', 'QuoteController@destroy');
//Send quote by email
Route::middleware('auth:api')->post('quote/send-email', 'QuoteController@sendEmail');

/**** Purchase Orders ****/
//Purchase orders list
Route::middleware('auth:api')->get('purchase-orders', 'PurchaseOrderController@index');
//Create a purchase order list
Route::middleware('auth:api')->post('purchase-order', 'PurchaseOrderController@store');
//Show a purchase order
Route::middleware('auth:api')->get('purchase-orders/{purchase_order}', 'PurchaseOrderController@show');
//Update purchase order
Route::middleware('auth:api')->put('purchase-orders/{purchase_order}', 'PurchaseOrderController@update');
//Update purchase order by patch
Route::middleware('auth:api')->patch('purchase-orders/{purchase_order}', 'PurchaseOrderController@changeStatus');

/**** Invoices ****/
//List invoices
Route::middleware('auth:api')->get('invoices', 'InvoiceController@index');
//Create an invoice
Route::middleware('auth:api')->post('invoice', 'InvoiceController@store');
//Edit an invoice
Route::middleware('auth:api')->put('invoice', 'InvoiceController@update');
//Show an invoice
Route::middleware('auth:api')->get('invoice/{invoice}', 'InvoiceController@show');
//Send invoice by email
Route::middleware('auth:api')->post('invoice/send-email', 'InvoiceController@sendEmail');
//Delete invoice
Route::middleware('auth:api')->delete('invoice/{invoice}', 'InvoiceController@destroy');
//Add recurrence to invoice
Route::middleware('auth:api')->post('invoice/add-recurrence', 'InvoiceController@addRecurrence');
//Cancel invoice recurrence
Route::middleware('auth:api')->delete('invoice/cancel-recurrence/{invoice}', 'InvoiceController@cancelRecurrence');

//Convert invoice in credit note
Route::middleware('auth:api')->post('credit-note', 'CreditNoteController@store');
//List credit notes
Route::middleware('auth:api')->get('credit-notes', 'CreditNoteController@index');
//Send credit note by email
Route::middleware('auth:api')->post('credit-note/send-email', 'CreditNoteController@sendEmail');
//Delete credit note
Route::middleware('auth:api')->delete('credit-note/{credit_note}', 'CreditNoteController@destroy');

//List taxes
Route::middleware('auth:api')->get('taxes', 'TaxController@index');
//Ajouter une taxe en ajax
Route::middleware('auth:api')->post('tax', 'TaxController@store');
//Modifier la taxe
Route::middleware('auth:api')->put('tax', 'TaxController@update');
//Delete tax
Route::middleware('auth:api')->delete('tax/{tax}', 'TaxController@destroy');

//List payment methods
Route::middleware('auth:api')->get('payment-methods', 'PaymentMethodController@index');
//Add a payment method
Route::middleware('auth:api')->post('payment-method', 'PaymentMethodController@store');
//Update a payment method
Route::middleware('auth:api')->put('payment-method', 'PaymentMethodController@update');
////Delete payment method
Route::middleware('auth:api')->delete('payment-method/{method}', 'PaymentMethodController@destroy');

//Add a payment
Route::middleware('auth:api')->post('payment', 'PaymentController@store');


