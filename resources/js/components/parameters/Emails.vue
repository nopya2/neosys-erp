<template>
    <div class="main-card mb-3 card">
        <div class="card-body">
            <h5 class="card-title">
                Paramétrage des e-mails
            </h5>
            <div class="position-relative form-group text-right">
                <button class="btn btn-primary mb-2 mt-0 mr-2" :disabled="spinnerEmail" @click="sendEmail()">
                    <span v-if="!spinnerEmail">M'envoyer un mail test</span>
                    <span v-if="spinnerEmail"><span class="spinner-border spinner-border-sm" role="status"></span> Envoi en cours...</span>
                </button>
                <button class="btn btn-success mb-2 mt-0" :disabled="spinner" @click="saveModel()">
                    <span v-if="!spinner">Enregistrer</span>
                    <span v-if="spinner"><span class="spinner-border spinner-border-sm" role="status"></span> Traitement en cours...</span>
                </button>
            </div>
            <div class="position-relative form-group">
                <select name="type" class="form-control" @change="selectModel(selected.id)" v-model="selected.id">
                    <option v-for="model in models" :value="model.id">{{ model.name }}</option>
                </select>
            </div>
            <div class="_w_parameters_containers">
                <h2 class="_w_parameters_headers">Modifier un e-mail : {{ selected.name }}</h2>
                <form class="scroll-area-lg">
                    <div class="_w_parameters_content scrollbar-container ps--active-y">
                        <div class="position-relative form-group">
                            <label for="object" class="">Objet</label>
                            <input name="object" id="object" placeholder="Votre" type="text" class="form-control" v-model="selected.object">
                        </div>
                        <div class="position-relative form-group">
                            <label for="senderName" class="">Nom de l'expéditeur</label>
                            <input name="senderName" id="senderName" placeholder="Votre" type="text" class="form-control" v-model="selected.sender_name">
                        </div>
                        <div class="position-relative form-group">
                            <label for="senderEmail" class="">E-mail de l'expéditeur</label>
                            <input name="senderEmail" id="senderEmail" placeholder="Votre" type="email" class="form-control" v-model="selected.sender_email">
                        </div>
                        <div class="custom-checkbox custom-control">
                            <label for="secondReceiver" class="">Second destinataire</label>
                            <input type="checkbox" id="secondReceiver" class="custom-control-input" v-model="selected.second_receiver">
                            <label class="custom-control-label" for="secondReceiver">Garder une copie du mail / Se mettre en copie par défaut</label>
                        </div>
                        <div class="position-relative form-group">
                            <label class="">Conteny de l'e-amil</label>
                            <!--<textarea name="body" id="body" class="form-control" rows="10" v-model="selected.body"></textarea>-->
                            <ckeditor :editor="editor" :config="editorConfig" v-model="selected.body"></ckeditor>
                        </div>
                        <div v-html="selected.description"><!---->
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
    import { required, minLength, maxLength } from 'vuelidate/lib/validators'
    import { Functions } from '../../scripts/functions'
    import ClassicEditor from '@ckeditor/ckeditor5-build-classic';

    export default {
        mounted() {
        },
        props: ['email_models'],

        data(){
            return{
                models: [],
                selected: {
                    id: null,
                    object: '',
                    sender_name: '',
                    sender_email: '',
                    second_receiver: false,
                    body: '',
                    description: ''
                },
                spinner: false,
                spinnerEmail: false,
                editor: ClassicEditor,
                editorConfig: {
                    // The configuration of the editor.
                }

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token
            }

            this.models = [...this.email_models]
            this.initSelected()

        },
        methods: {
            initSelected(){
                let index = this.models.findIndex(x => x.id === 1);
                if(index !== -1)
                    this.selected = {...this.models[index]};
            },
            selectModel(id){
                let index = this.models.findIndex(x => x.id === id);
                if(index !== -1)
                    this.selected = {...this.models[index]};
            },
            saveModel(){
                this.spinner = true
                fetch(`/api/parameters/email-models?api_token=${this.api_token}`, {
                    method: 'PUT',
                    body: JSON.stringify(this.selected),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    // .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        if (res.ok){
                            res.json().then(result =>{
                                Functions.showAlert('top-end', 'success', 'Modifications enregistrées!')
                            })

                        }else{
                            res.json().then(error =>{
                                Functions.showAlert('top-end', 'error', 'Erreur de l\'enregistrement!')
                            })

                        }
                    })
                    .catch(error => {
                        this.spinner = false
                        Functions.showAlert('top-end', 'danger', 'Erreur traitement!')
                    });
            },
            sendEmail(){
                this.spinnerEmail = true
                fetch(`/api/parameters/send-email-test?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: JSON.stringify(this.selected),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                // .then(res => res.json())
                    .then(res => {
                        this.spinnerEmail = false
                        if (res.ok){
                            res.json().then(result =>{
                                Functions.showAlert('top-end', 'success', 'E-mail envoyé!')
                            })

                        }else{
                            res.json().then(error =>{
                                Functions.showAlert('top-end', 'error', 'Erreur d\'envoi du mail!')
                            })

                        }
                    })
                    .catch(error => {
                        this.spinnerEmail = false
                        Functions.showAlert('top-end', 'danger', 'Erreur traitement!')
                    });
            },
        }

    }
</script>
