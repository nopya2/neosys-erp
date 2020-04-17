<template>
    <div class="main-card mb-3 card">
        <div class="card-body">
            <h5 class="card-title">
                Paramétrage des e-mails
                <button class="btn btn-success float-right mb-2 mt-0">Enregistrer</button>
            </h5>
            <div class="position-relative form-group">
                <select name="type" class="form-control">
                    <option>Envoi d'un devis</option>
                    <option>Envoi d'une facture</option>
                    <option>Relance d'une facture</option>
                </select>
            </div>
            <div class="_w_parameters_containers">
                <h2 class="_w_parameters_headers">Modifier un e-mail : Envoi d'un devis</h2>
                <form class="scroll-area-lg">
                    <div class="_w_parameters_content scrollbar-container ps--active-y">
                        <div class="position-relative form-group">
                            <label for="object" class="">Objet</label>
                            <input name="object" id="object" placeholder="Votre" type="text" class="form-control">
                        </div>
                        <div class="position-relative form-group">
                            <label for="senderName" class="">Nom de l'expéditeur</label>
                            <input name="senderName" id="senderName" placeholder="Votre" type="text" class="form-control">
                        </div>
                        <div class="position-relative form-group">
                            <label for="senderEmail" class="">E-mail de l'expéditeur</label>
                            <input name="senderEmail" id="senderEmail" placeholder="Votre" type="email" class="form-control">
                        </div>
                        <div class="custom-checkbox custom-control">
                            <label for="secondReceiver" class="">Second destinataire</label>
                            <input type="checkbox" id="secondReceiver" class="custom-control-input">
                            <label class="custom-control-label" for="secondReceiver">Garder une copie du mail / Se mettre en copie par défaut</label>
                        </div>
                        <div class="position-relative form-group">
                            <label for="body" class="">Conteny de l'e-amil</label>
                            <textarea name="body" id="body" class="form-control" rows="10"></textarea>
                        </div>
                        <div role="alert" aria-live="polite" aria-atomic="true" class="alert alert-info"><!---->
                            <small>
                                <div>
                                    Vous pouvez utiliser les balises spéciales suivantes dans le contenu de l'e-mail. Elles seront remplacées
                                    par leurs vraies valeurs à l'envoi de l'e-mail.
                                </div>
                                <div>
                                    <div><b>[devis-numero]</b> : Remplacé par le numéro du devis</div>
                                    <div><b>[nomprenom_utilisateur]</b> : Remplacé par le prénom et le nom de l'utilisateur</div>
                                    <div><b>[email_utilisateur]</b> : Remplacé par le mail de l'utilisateur</div>
                                    <div><b>[lien-html]</b> : Renverra un lien vers votre devis au format HTML.</div>
                                    <div><b>[lien-pdf]</b> : Renverra un lien vers votre devis au format PDF.</div>
                                    <div><b>[interlocuteur-nom]</b> : Renverra le nom du collaborateur ayant généré ce devis.</div>
                                    <div><b>[contact-nom]</b> : Renverra le nom du contact client noté sur ce devis.</div>
                                </div> <!----> <!----> <!---->
                            </small>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
    import { required, minLength, maxLength } from 'vuelidate/lib/validators'

    export default {
        mounted() {
        },

        data(){
            return{


            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token
            }

        },

        methods: {

        }

    }
</script>
