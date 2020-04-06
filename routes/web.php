<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Route::get('/', function () {
//    return view('home');
//});

Route::redirect('/', '/home');

Auth::routes();

Route::get('/home', 'HomeController@home')->name('home')->middleware('auth');
//Route::get('/home', 'HomeController@index')->name('home')->middleware('auth');
Route::get('/test', 'HomeController@test')->name('test');
Route::get('/information', 'InformationController@edit')->name('information')->middleware('auth');
Route::get('/parameters', 'ParameterController@index')->name('parameters')->middleware('auth');
Route::get('/send-mail', 'InformationController@sendMail')->name('send_mail');

/***** Users ****/
//Route::get('/users', 'UserController@home')->name('user.index')->middleware('auth')->middleware('permissions:user,read');
Route::get('/users', 'UserController@home')->name('user.index')->middleware('auth');
//Route::get('/user/create', 'UserController@create')->name('user.create')->middleware('auth')->middleware('permissions:user,create');
Route::get('/user/create', 'UserController@create')->name('user.create')->middleware('auth');
//Route::post('/user', 'UserController@store')->name('user.store')->middleware('auth')->middleware('permissions:user,create');
Route::post('/user', 'UserController@store')->name('user.store')->middleware('auth');
//Route::get('/user/{user}/edit', 'UserController@edit')->name('user.edit')->middleware('auth')->middleware('permissions:user,edit');
Route::get('/user/{user}/edit', 'UserController@edit')->name('user.edit')->middleware('auth');
//Route::post('/user/{user}/edit', 'UserController@update')->name('user.update')->middleware('auth')->middleware('permissions:user,edit');
Route::post('/user/{user}/edit', 'UserController@update')->name('user.update')->middleware('auth');

/***** Engagements ****/
Route::get('/engagements', 'EngagementController@home')->name('engagement.index')->middleware('auth');
Route::get('/engagements/{engagement}', 'EngagementController@show')->name('engagement.show')->middleware('auth');
Route::get('/search', 'EngagementController@search')->name('engagement.search')->middleware('auth');

/***** Echelons ****/
Route::get('/echelons', 'EchelonController@home')->name('echelon.index')->middleware('auth');

/***** Providers ****/
Route::get('/providers', 'ProviderController@home')->name('provider.index')->middleware('auth');

/***** Customers ****/
Route::get('/customers', 'CustomerController@home')->name('customer.index')->middleware('auth');
Route::get('/customer/create', 'CustomerController@create')->name('customer.create')->middleware('auth');
Route::post('/customer', 'CustomerController@store')->name('customer.store')->middleware('auth');
Route::get('/customer/{customer}/edit', 'CustomerController@edit')->name('customer.edit')->middleware('auth');
Route::post('/customer/{customer}/edit', 'CustomerController@update')->name('customer.update')->middleware('auth');

/***** Quotes ****/
Route::get('/quotes', 'QuoteController@home')->name('quote.index')->middleware('auth');
Route::get('/quote/create', 'QuoteController@create')->name('quote.create')->middleware('auth');
Route::post('/quote', 'QuoteController@store')->name('quote.store')->middleware('auth');
Route::get('/quote/{quote}/edit', 'QuoteController@edit')->name('quote.edit')->middleware('auth');
Route::post('/quote/{quote}/edit', 'QuoteController@update')->name('quote.update')->middleware('auth');
Route::get('/quote/print/{id}', 'QuoteController@printQuote')->name('quote.print')->middleware('auth');
Route::get('/quote/bill/{quote}', 'QuoteController@billQuote')->name('quote.bill')->middleware('auth');
Route::get('/quote/duplicate/{quote}', 'QuoteController@duplicateQuote')->name('quote.duplicate')->middleware('auth');
Route::get('/quote/purchase-order/print/{quote}', 'QuoteController@printPurchaseOrder')->name('quote.purchase-order.print')->middleware('auth');

/***** Invoices ****/
Route::get('/invoices', 'InvoiceController@home')->name('invoice.index')->middleware('auth');
Route::get('/invoice/create', 'InvoiceController@create')->name('invoice.create')->middleware('auth');
Route::post('/invoice', 'InvoiceController@store')->name('invoice.store')->middleware('auth');
Route::get('/invoice/{invoice}/edit', 'InvoiceController@edit')->name('invoice.edit')->middleware('auth');
Route::post('/invoice/{invoice}/edit', 'InvoiceController@update')->name('invoice.update')->middleware('auth');
Route::get('/invoice/print/{id}', 'InvoiceController@printInvoice')->name('invoice.print')->middleware('auth');
Route::get('/invoice/duplicate/{invoice}', 'InvoiceController@duplicateInvoice')->name('invoice.duplicate')->middleware('auth');

/***** Credit Notes *****/
Route::get('/credit-notes', 'CreditNoteController@home')->name('credit_note.index')->middleware('auth');
Route::get('/credit-note/create', 'CreditNoteController@create')->name('credit_note.create')->middleware('auth');
Route::get('/credit-note/print/{credit_note}', 'CreditNoteController@printCreditNote')->name('credit_note.print')->middleware('auth');

/***** Taxes ****/
Route::get('/taxes', 'TaxController@home')->name('tax.index')->middleware('auth');
Route::get('/tax/create', 'TaxController@create')->name('tax.create')->middleware('auth');
Route::post('/tax', 'TaxController@store')->name('tax.store')->middleware('auth');
Route::get('/tax/{tax}/edit', 'TaxController@edit')->name('tax.edit')->middleware('auth');
Route::post('/tax/{tax}/edit', 'TaxController@update')->name('tax.update')->middleware('auth');



