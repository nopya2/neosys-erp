<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en"><head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <title>{{ 'NST-CN'.$credit_note->credit_note_number.'.pdf' }}</title>
    <style type="text/css">

        @page {
            margin: 2cm;
        }

        body {
            /*font-family: sans-serif;*/
            font-family: Century Gothic,CenturyGothic,AppleGothic,sans-serif;
            margin: 0.5cm 0;
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
            height: 50px;
        }

        #footer p{
            margin: 0px;
            padding: 0px;
        }

        #header table,
        #footer table {
            width: 100%;
            border-collapse: collapse;
            border: none;
        }

        #header td,
        #footer td {
            padding: 0;
            width: 50%;
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

        /*table.table-items th{*/
            /*border: 0.1pt solid red;*/
            /*height: 30px;*/
            /*background: #EEECE1;*/
        /*}*/

        /*table.table-items td {*/
            /*border: 0.1pt solid red;*/
            /*height: 25px;*/
        /*}*/

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
            padding: 5px;
        }

    </style>

</head>

<body marginwidth="0" marginheight="0">

    {{--<div id="header">--}}
        {{--<table>--}}
            {{--<tbody>--}}
            {{--<tr>--}}
                {{--<td>Example document</td>--}}
                {{--<td style="text-align: right;">Author</td>--}}
            {{--</tr>--}}
            {{--</tbody>--}}
        {{--</table>--}}
    {{--</div>--}}

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
                        AVOIR N° {{ $credit_note->credit_note_number }}<br>
                        <span style="font-size: 9px">
                            Avoir sur facture n°{{ $credit_note->invoice->invoice_number }} du {{ $credit_note->invoice->updated_at->format('d/m/Y') }}
                        </span>
                    </div>
                    <div class="infos-client">
                        {{ $credit_note->invoice->customer->company_name }}<br>
                        Tel: {{ $credit_note->invoice->customer->phonenumber }}<br>
                        {{ $credit_note->invoice->customer->address }}
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; font-style: italic">
                    A {{ $information->city }}, le <span style="font-weight: bold">{{ $credit_note->updated_at->format('d/m/Y') }}</span><br>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div style="margin-top: 20px">
        {{--<p style="font-weight: bold; font-style: italic; margin: 0; padding: 0">{{ $invoice->title }}</p>--}}
        <table class="table-items" style="width: 100%; margin-top: 5px">
            <thead>
            <tr>
                <th style="border: 0.1pt solid red; height: 30px; background: #EEECE1">Produits et prestations</th>
                <th style="border: 0.1pt solid red; height: 30px; background: #EEECE1">PU HT</th>
                <th style="border: 0.1pt solid red; height: 30px; background: #EEECE1">Quantité</th>
                <th style="border: 0.1pt solid red; height: 30px; background: #EEECE1">Total HT</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="border-right: 0.1pt solid red; height: 300px; padding: 5px; border-left: 0.1pt solid red; vertical-align: top" width="300px">
                    <span style="font-weight: bold">{{ $credit_note->invoice->title }}</span><br>
                    @foreach($credit_note->invoice->items as $item)
                    <span style="font-size: 12px">{{ $item->qty }} x {{ $item->label }} ({{ number_format($item->pu, 0, ',', ' ') }} XAF HT)<br></span>
                    @endforeach
                </td>
                <td style="text-align: right; border-right: 0.1pt solid red; height: 30px; padding: 5px; border-left: 0.1pt solid red; vertical-align: top">
                    {{ number_format($total_HT, 0, ',', ' ') }}
                </td>
                <td style="text-align: right; border-right: 0.1pt solid red; height: 30px; padding: 5px; border-left: 0.1pt solid red; vertical-align: top">
                    1
                </td>
                <td style="text-align: right; border-right: 0.1pt solid red; height: 30px; padding: 5px; border-left: 0.1pt solid red; vertical-align: top">
                    {{ number_format($total_HT, 0, ',', ' ') }}
                </td>
            </tr>
            <tr>
                <td style="border-right: 0.1pt solid red; height: 30px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
                <td style="border-right: 0.1pt solid red; height: 30px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
                <td style="border-right: 0.1pt solid red; height: 30px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
                <td style="border-right: 0.1pt solid red; height: 30px; border-bottom: 0.1pt solid red; border-left: 0.1pt solid red"></td>
            </tr>

            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">Total HT</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">{{ number_format($total_HT, 0, ',', ' ') }}</td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">Remise ({{ $credit_note->invoice->discount }}%)</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">
                    {{ number_format(($discount = $total_HT * $credit_note->invoice->discount/100), 0, ',', ' ') }}
                </td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">Net commercial</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">
                    {{ number_format($amount_discount = $total_HT - $discount, 0, ',', ' ') }}
                </td>
            </tr>
            @foreach($credit_note->invoice->taxes as $tax)
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">{{ $tax->name }} ({{ $tax->value }}%)</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">{{ number_format(($amount_discount * $tax->value) / 100, 0, ',', ' ') }}</td>
            </tr>
            @endforeach
            <tr>
                <td colspan="2"></td>
                <th style="text-align: right; border: 0.1pt solid red; background: #EEECE1">Net à payer</th>
                <td colspan="1" style="text-align: right; border: 0.1pt solid red">{{ number_format($credit_note->amount, 0, ',', ' ') }}</td>
            </tr>
            </tbody>
        </table>
    </div>

    <div style="margin-top: 15px">
        Cette facture d'avoir est arrêtée à la somme de <b>{{$amount_to_words}} Francs CFA</b>
    </div>
    {{--<div style="margin-top: 15px; font-style: italic; font-size: 13px">Validité de la facture 30 jours</div>--}}

</body>
</html>