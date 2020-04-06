<template>
    <form class="">
        <div class="mb-3 card">
            <!--<div class="card-header-tab card-header-tab-animation card-header">-->
                <!--&lt;!&ndash;<div class="card-header-title font-size-lg text-capitalize font-weight-normal"><i class="header-icon lnr-gift icon-gradient bg-love-kiss"> </i>Tabs Alternate Animation</div>&ndash;&gt;-->
                <!---->
            <!--</div>-->
            <div class="card-body">
                <ul class="tabs-animated-shadow nav-justified tabs-animated nav">
                    <li class="nav-item">
                        <a role="tab" class="nav-link show active" id="tab-c1-0" data-toggle="tab" href="#tab-animated1-0" aria-selected="true">
                            <span class="nav-text">Informations générales</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a role="tab" class="nav-link show" id="tab-c1-1" data-toggle="tab" href="#tab-animated1-1" aria-selected="false">
                            <span class="nav-text">Informations bancaires</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a role="tab" class="nav-link show" id="tab-c1-2" data-toggle="tab" href="#tab-animated1-2" aria-selected="false">
                            <span class="nav-text">Entête et pied de page</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a role="tab" class="nav-link show" id="tab-c1-3" data-toggle="tab" href="#tab-animated1-3" aria-selected="false">
                            <span class="nav-text">Autres informations</span>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane show active mt-3" id="tab-animated1-0" role="tabpanel">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <img :src="'/img/uploads/logo/'+information.logo" height="100px" width="auto" v-show="!showPreview"/>
                                    <img v-bind:src="imagePreview" v-show="showPreview" height="100px" width="auto"/>
                                    <br>
                                    <input type="file" @change="handleFileUpload" ref="file" accept="image/*" id="file">
                                    <button class="btn btn-xs btn-outline-success border-0" title="Enregistrer" v-if="showCheckButton"
                                        @click="uploadFile" type="button">
                                        <i class="fa fa-check"></i>
                                    </button>
                                    <button class="btn btn-xs btn-outline-danger border-0" title="Annuler" v-if="showCancelButton"
                                        @click="cancelUploadFile" type="button">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Raison sociale</label>
                                    <input class="form-control" type="text" name="social_reason" v-model="$v.information.social_reason.$model">
                                    <small class="form-text text-danger" v-if="!$v.information.social_reason.required">Champs requis.</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Adresse</label>
                                    <textarea class="form-control" v-model="$v.information.address.$model"></textarea>
                                    <small class="form-text text-danger" v-if="!$v.information.address.required">Champs requis.</small>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Contact1</label>
                                    <input class="form-control" type="text" name="contact1" v-model="$v.information.phone1.$model">
                                    <small class="form-text text-danger" v-if="!$v.information.phone1.required">Champs requis.</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Contact2</label>
                                    <input class="form-control" type="text" name="contact2" v-model="$v.information.phone2.$model">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Email</label>
                                    <input class="form-control" type="email" name="email" v-model="$v.information.email.$model">
                                    <small class="form-text text-danger" v-if="!$v.information.email.required">Champs requis.</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Site web</label>
                                    <input class="form-control" type="text" name="website" v-model="$v.information.website.$model">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Pays</label>
                                    <input class="form-control" type="text" name="country" v-model="$v.information.country.$model">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Ville</label>
                                    <input class="form-control" type="text" name="city" v-model="$v.information.city.$model">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Boite postale</label>
                                    <input class="form-control" type="text" name="bp" v-model="$v.information.bp.$model">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane show mt-3" id="tab-animated1-1" role="tabpanel">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Chèque à l'ordre de</label>
                                    <input class="form-control" type="text" name="check_payable_to" v-model="$v.information.check_payable_to.$model">
                                    <small class="form-text text-danger" v-if="!$v.information.check_payable_to.required">Champs requis.</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Virement au compte</label>
                                    <input class="form-control" type="text" name="transfer_to_account" v-model="$v.information.transfer_to_account.$model">
                                    <small class="form-text text-danger" v-if="!$v.information.transfer_to_account.required">Champs requis.</small>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Code banque</label>
                                    <input class="form-control" type="text" name="code_bank" v-model="$v.information.code_bank.$model">
                                    <!--<small class="form-text text-danger" v-if="!$v.information.code_bank.required">Champs requis.</small>-->
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Code guichet</label>
                                    <input class="form-control" type="text" name="counter_code" v-model="$v.information.counter_code.$model">
                                    <!--<small class="form-text text-danger" v-if="!$v.information.transfer_to_account.required">Champs requis.</small>-->
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Numéro de compte</label>
                                    <input class="form-control" type="text" name="account_number" v-model="$v.information.account_number.$model">
                                    <!--<small class="form-text text-danger" v-if="!$v.information.check_payable_to.required">Champs requis.</small>-->
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Clé RIB</label>
                                    <input class="form-control" type="text" name="rib_key" v-model="$v.information.rib_key.$model">
                                    <!--<small class="form-text text-danger" v-if="!$v.information.transfer_to_account.required">Champs requis.</small>-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane show mt-3" id="tab-animated1-2" role="tabpanel">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Entête </label>
                                    <!--<textarea class="form-control" name="header"></textarea>-->
                                    <ckeditor :editor="editor" v-model="$v.information.header.$model" :config="editorConfig"></ckeditor>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Pied de page <small class="text-danger" v-if="!$v.information.footer.required">Champs requis</small></label>
                                    <!--<textarea class="form-control" name="footer"></textarea>-->
                                    <ckeditor :editor="editor" v-model="$v.information.footer.$model" :config="editorConfig"></ckeditor>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane show mt-3" id="tab-animated1-3" role="tabpanel">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Delai du devis </label>
                                    <input type="number" class="form-control" name="quote_delay" v-model="$v.information.quote_delay.$model"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Délai de la facture </label>
                                    <input type="number" class="form-control" name="invoice_delay" v-model="$v.information.invoice_delay.$model"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Délai du bon de commande </label>
                                    <input type="number" class="form-control" name="purchase_order_delay" v-model="$v.information.purchase_order_delay.$model"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-block text-center card-footer">
                <button class="btn btn-success" type="button" :disabled="$v.information.$invalid" @click="saveInformation" v-if="!btnLoading">
                    <i class="fa fa-save"></i> Enregistrer
                </button>
                <button class="btn btn-success shadow-2" type="button" disabled="" v-if="btnLoading">
                    <span class="spinner-grow spinner-grow-sm" role="status"></span>
                    Enregistrement en cours...
                </button>
            </div>
        </div>
    </form>

</template>

<script>
    import { required } from 'vuelidate/lib/validators'
    import ClassicEditor from '@ckeditor/ckeditor5-build-classic';

    export default {
        props : ['information_data'],
        data(){
            return{
                information: {
                    id: '',
                    social_reason: '',
                    address: '',
                    phone1: '',
                    phone2: '',
                    email: '',
                    country: '',
                    city: '',
                    bp: '',
                    website: '',
                    check_payable_to: '',
                    transfer_to_account: '',
                    code_bank: '',
                    counter_code: '',
                    account_number: '',
                    rib_key: '',
                    header: '',
                    footer: '',
                    quote_delay: '',
                    invoice_delay: '',
                    purchase_order_delay: 0,
                    updated_at: ''
                },
                editor: ClassicEditor,
                editorData: '<p>Content of the editor.</p>',
                editorConfig: {
                    // The configuration of the editor.
                },
                file: {},
                showPreview: false,
                showCheckButton: false,
                showCancelButton: false,
                imagePreview: '',
                csrfToken: null,
                api_token: '',
                btnLoading: false

            }
        },
        validations: {
            information: {
                social_reason: {
                    required
                },
                address: {
                    required
                },
                phone1: {
                    required
                },
                phone2: {
                },
                email: {
                    required
                },
                country: {
                    required
                },
                city: {
                    required
                },
                bp: {
                },
                website: {
                },
                check_payable_to: {
                    required
                },
                transfer_to_account: {
                    required
                },
                code_bank: {
                    // required
                },
                counter_code: {
                    // required
                },
                account_number: {
                    // required
                },
                rib_key: {
                    // required
                },
                header: {
                },
                footer: {
                    required
                },
                quote_delay: {

                },
                invoice_delay: {

                },
                purchase_order_delay: {}
            },
        },
        mounted() {
        },
        created(){
            if (window.localStorage.getItem('authUser')) {
                const authCustomer = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authCustomer.api_token
            }

            this.csrfToken = document.querySelector('meta[name="csrf-token"]').content

            this.information = { ...this.information_data }
        },

        methods: {
            saveInformation(){
                this.btnLoading = true
                fetch(`/api/information?api_token=${this.api_token}`, {
                    method: 'PUT',
                    body: JSON.stringify(this.information),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        this.information = res.data
                        this.btnLoading = false
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Informations enregistrée!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    })
                    .catch(error => {
                        this.btnLoading = false
                        this.$swal({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Erreur enregistrement!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    });
            },
            handleFileUpload(){
                /*
                    Set the local file variable to what the user has selected.
                */
                this.file = this.$refs.file.files[0];

                /*
                  Initialize a File Reader object
                */
                let reader  = new FileReader();

                /*
                  Add an event listener to the reader that when the file
                  has been loaded, we flag the show preview as true and set the
                  image to be what was read from the reader.
                */
                reader.addEventListener("load", function () {
                    this.showPreview = true;
                    this.showCheckButton = true;
                    this.showCancelButton = true;
                    this.imagePreview = reader.result;
                }.bind(this), false);

                /*
                  Check to see if the file is not empty.
                */
                if( this.file ){
                    /*
                      Ensure the file is an image file.
                    */
                    if ( /\.(jpe?g|png|gif)$/i.test( this.file.name ) ) {
                        /*
                          Fire the readAsDataURL method which will read the file in and
                          upon completion fire a 'load' event which we will listen to and
                          display the image in the preview.
                        */
                        reader.readAsDataURL( this.file );
                    }
                }
            },
            uploadFile(){
                let formData = new FormData()
                formData.append('file', this.file);
                formData.append('id', this.information.id);

                fetch(`/api/information?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: formData
                })
                    .then(res => res.json())
                    .then(res => {
                        this.information = res.data
                        this.showCancelButton = false
                        this.showCheckButton = false;
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Image enregistrée!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    })
                    .catch(error => {
                        this.btnLoading = false
                        this.$swal({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Erreur enregistrement!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    });
            },
            cancelUploadFile(){
                this.showCancelButton = false
                this.showCheckButton = false;
                this.showPreview = false;
            }
        }

    }
</script>
