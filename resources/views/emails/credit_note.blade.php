<p>Madame/Monsieur,</p>

<p>
    Suite à "{{ $credit_note->text_type }}" au sujet de "{{ $credit_note->invoice->title }}"
    {{--correspondant au [bon de commande/contrat/devis] n° (X)--}}
    , nous vous adressons ci-joint un avoir d'un montant de {{ number_format($credit_note->amount, 0, ',', ' ') }} XAF.</p>

<p>En vous remerciant par avance,</p>

<p>Cordialement</p>

<p style="font-style: italic;">
    <small>Si le mail n'apparait pas, veuillez vérifier le dossier spam.</small>
</p>