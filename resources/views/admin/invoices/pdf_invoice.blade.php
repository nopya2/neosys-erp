<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en"><head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <title>{{ 'NST-Q'.$invoice->invoice_number.'.pdf' }}</title>
    <style type="text/css">

        @page {
            margin: 2cm;
        }

        body {
            /*font-family: sans-serif;*/
            font-family: Century Gothic,CenturyGothic,AppleGothic,sans-serif;
            margin: 0.3cm 0;
            text-align: justify;
            font-size: 14px;
        }

        #header,
        #footer {
            position: fixed;
            left: 0;
            right: 0;
            color: #aaa;
            font-size: 0.9em;
        }

        #header {
            top: 0;
            border-bottom: 0.1pt solid #aaa;
        }

        #footer {
            bottom: 0;
            border-top: 0.1pt solid #aaa;
            height: 40px;
        }

        #footer p{
            margin: 0px;
            padding: 0px;
        }

        .page-number {
            text-align: center;
        }

        .page-number:before {
            content: "Page " counter(page);
        }

        hr {
            page-break-after: always;
            border: 0;
        }

        table.table-items{
            border-collapse: collapse;
            /*border: 0.1pt solid red;*/
        }

        .numero-facture{
            width: 100%;
            min-height: 200px;
            border: 0.1pt solid red;
            border-radius: 5px;
            text-align: center;
            min-height: 200px;
            margin-bottom: 10px;
            font-size: 20px;
            padding: 10px;
        }

        .infos-client{
            width: 100%;
            border: 0.1pt solid red;
            border-radius: 5px;
            text-align: center;
        }

    </style>

</head>

<body marginwidth="0" marginheight="0">

    <div id="footer">
        {{--<div class="page-number"></div>--}}
        {!! $information->footer !!}
    </div>

    <div>
        <table style="width: 100%">
            <tbody>
            <tr>
                <td>
                    <img src="img/uploads/logo/{{$information->logo}}" height="80px" width="auto">
                    <p>
                        Votre contact: <br>
                        Tel: {{ $information->phone1 }}{{ ' -'.$information->phone2 }}<br>
                        Email: {{ $information->email }}
                    </p>
                </td>
                <td>
                    <div class="numero-facture">
                        FACTURE N° {{ $invoice->invoice_number }}
                    </div>
                    <div class="infos-client">
                        {{ $invoice->customer->company_name }}<br>
                        Tel: {{ $invoice->customer->phonenumber }}<br>
                        {{ $invoice->customer->address }}
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; font-style: italic">
                    A {{ $information->city }}, le <span style="font-weight: bold">{{ date('d/m/Y') }}</span><br>
                    Echéance: {{ $information->invoice_delay }} jours<br>
                    Soit: le {{ $invoice->expire_at->format('d/m/Y') }}
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div style="table-layout: fixed; margin-top: 20px">
        <p style="font-weight: bold; font-style: italic; margin: 0; padding: 0">{{ $invoice->title }}</p>
        <table class="table-items" style="width: 100%; margin-top: 5px">
            <thead>
            <tr>
                <th style="border: 0.1pt solid red; height: 30px; background: #EEECE1">Désignation</th>
                <th style="border: 0.1pt solid red; height: 30px; background: #EEECE1">Prix Unitaire</th>
                <th style="border: 0.1pt solid red; height: 30px; background: #EEECE1">Quantité</th>
                <th style="border: 0.1pt solid red; height: 30px; background: #EEECE1">Montant HT</th>
            </tr>
            </thead>
            <tbody>
            @foreach($invoice->items as $item)
            <tr>
                <td style="border-right: 0.1pt solid red; padding: 0 0 0 5px; border-left: 0.1pt solid red" width="300px">
                {{ $item->label }}
                </td>
                <td style="text-align: right; border-right: 0.1pt solid red; padding: 0 0 0 5px; border-left: 0.1pt solid red">
                {{ number_format($item->pu, 0, ',', ' ') }}
                </td>
                <td style="text-align: right; border-right: 0.1pt solid red; padding: 0 0 0 5px; border-left: 0.1pt solid red">
                {{ number_format($item->qty,0, ',', ' ') }}
                </td>
                <td style="text-align: right; border-right: 0.1pt solid red; padding: 0 0 0 5px; border-left: 0.1pt solid red">
                    {{--@convert($item->amount)--}}
                {{ number_format($item->amount,0, ',', ' ') }}
                </td>
            </tr>
            @endforeach
            <tr>
                @if(count($invoice->items) >= 20)
                    <td style="border-right: 0.1pt solid red; height: 30px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
                @else
                    <td style="border-right: 0.1pt solid red; height: 120px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
                @endif
                <td style="border-right: 0.1pt solid red; height: 30px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
                <td style="border-right: 0.1pt solid red; height: 30px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
                <td style="border-right: 0.1pt solid red; height: 30px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">Montant Total HT</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">{{ number_format($invoice->amount_et, 0, ',', ' ') }}</td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">Remise ({{ $invoice->discount }}%)</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">
                    {{ number_format(($invoice->amount_et * $invoice->discount) /100, 0, ',', ' ') }}
                </td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">Net commercial</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">
                    {{ number_format($invoice->amount_discount, 0, ',', ' ') }}
                </td>
            </tr>
            @foreach($invoice->taxes as $tax)
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">{{ $tax->name }} ({{ $tax->value }}%)</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">{{ number_format(($invoice->amount_discount * $tax->value) / 100, 0, ',', ' ') }}</td>
            </tr>
            @endforeach
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">Net à payer</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">{{ number_format($invoice->amount, 0, ',', ' ') }}</td>
            </tr>
            </tbody>
        </table>
    </div>

    <div style="font-size: 11px; border: 1px solid red; width: 390px; margin-top: -112px; padding: 5px">
        Conditions de règlement<br>
        - 60% à la commande sur présentation du bon de livraison<br>
        Paiement par
        - Chèque à l'ordre de: <br>
        - Virement au compte: <br>
        <table>
            <tr>
                <td style="text-align: center">Code banque</td>
                <td style="text-align: center">Code guichet</td>
                <td style="text-align: center">N° de compte</td>
                <td style="text-align: center">Clé RIB</td>
            </tr>
            <tr>
                <td style="text-align: center; font-weight: bold">{{ $information->code_bank }}</td>
                <td style="text-align: center; font-weight: bold">{{ $information->counter_code }}</td>
                <td style="text-align: center; font-weight: bold">{{ $information->account_number }}</td>
                <td style="text-align: center; font-weight: bold">{{ $information->rib_key }}</td>
            </tr>
        </table>
        Délai de livraison <br>
        - Après la réception de l'accompte
    </div>

    <div style="margin-top: 10px">
        Cette facture est arrêtée à la somme de <b>{{$amount_to_words}} Francs CFA</b>
    </div>
    {{--<div style="margin-top: 15px; font-style: italic; font-size: 13px">Validité de la facture 30 jours</div>--}}

</body>
</html>