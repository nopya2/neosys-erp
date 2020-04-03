<p>Madame/Monsieur,</p>

<p>
    Suite à {{ $invoice->title }}
    {{--correspondant au [bon de commande/contrat/devis] n° (X)--}}
    , nous vous adressons ci-joint une facture d'un montant de {{ number_format($invoice->amount, 0, ',', ' ') }} XAF.</p>

<p>En vous remerciant par avance,</p>

<p>Cordialement</p>

<p style="font-style: italic;">
    <small>Si le mail n'apparait pas, veuillez vérifier le dossier spam.</small>
</p>