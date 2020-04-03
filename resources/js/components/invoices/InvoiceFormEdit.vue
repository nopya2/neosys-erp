<template>
    <form class="">
        <div class="row mb-3">
            <div class="col-md-6">
                <button class="btn btn-primary" type="button" disabled="" v-if="spinner">
                    <span class="spinner-border spinner-border-sm" role="status"></span>
                    <span class="sr-only">Loading...</span>
                </button>
                <!--<div class="mb-2 mr-2 badge badge-dark float-right" v-if="invoice.expired">Expiré</div>-->
                <div class="dropdown d-inline-block">
                    <button type="button" aria-haspopup="true" aria-expanded="false" data-toggle="dropdown"
                            class="dropdown-toggle btn btn-primary" id="dropdownMenuButton">Actions</button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <!--<button type="button" tabindex="0" class="dropdown-item text-secondary" @click="openInvoice(invoice.id,'edit')" v-if="!invoice.expired">-->
                            <!--<i class="fa fa-edit"></i>&nbsp;Editer-->
                        <!--</button>-->
                        <button type="button" class="dropdown-item" @click="validateInvoice" :disabled="invoice.status == 1">
                            <i class="fa fa-check"></i>&nbsp;Valider
                        </button>
                        <button type="button" class="dropdown-item" @click="addModalPayment" :disabled="invoice.status == 0 || invoice.is_paid">
                            <i class="fa fa-credit-card"></i>&nbsp;Enregistrer un paiement
                        </button>
                        <div class="dropdown-divider"></div>
                        <button type="button" class="dropdown-item" @click="convertInvoice(invoice.id)" :disabled="invoice.status == 0 || invoice.amount_paid > 0">
                            <i class="fa fa-file"></i>&nbsp;Convertir en facture d'avoir
                        </button>
                        <button type="button" class="dropdown-item" :disabled="invoice.status == 0" @click="addRecurrence">
                            <i class="fa fa-clock"></i>&nbsp;Récurrence
                        </button>
                        <div class="dropdown-divider"></div>
                        <button type="button" class="dropdown-item" :disabled="invoice.status == 0" @click="printInvoice(invoice.id)">
                            <i class="fa fa-print"></i>&nbsp;Imprimer
                        </button>
                        <button type="button" class="dropdown-item" :disabled="invoice.status == 0" @click="sendEmail()">
                            <i class="fa fa-envelope"></i>&nbsp;Envoyer
                        </button>
                        <div class="dropdown-divider"></div>
                        <button type="button" class="dropdown-item" :disabled="invoice.status == 0" disabled>
                            <i class="fa fa-print"></i>&nbsp;Imprimer bon de livraison
                        </button>
                        <div class="dropdown-divider"></div>
                        <button type="button" class="dropdown-item" @click="duplicateInvoice(invoice.id)">
                            <i class="fa fa-clone"></i>&nbsp;Dupliquer
                        </button>
                        <button type="button" class="dropdown-item" :disabled="invoice.status == 1" @click="deleteInvoice(invoice.id)">
                            <i class="fa fa-trash"></i>&nbsp;Supprimer
                        </button>
                    </div>
                </div>
                <button class="btn btn-info" @click="openModalHistory" type="button">
                    <i class="fa fa-history"></i>&nbsp; Historique des paiements
                </button>
            </div>

            <div class="col-md-6">
                <button class="btn btn-success" disabled>
                    Montant payé: {{ invoice.amount_paid | numFormat }}
                </button>
                <button class="btn btn-dark" disabled>
                    Reste à payer: {{ invoice.amount_remaining | numFormat }}
                </button>
                <div class="badge badge-dark float-right" v-if="invoice.status == 0">Brouillon</div>
                <div class="float-right" v-if="invoice.status == 1 && !invoice.is_paid">
                    <div class="badge badge-success float-right"><i class="fa fa-check-circle"></i>&nbsp;Validé</div><br>
                    <span>
                        <small>{{ invoice.deadline.d }} jour(s) restant</small>
                    </span>
                </div>
                <div class="badge badge-success float-right" v-if="invoice.is_paid">Payé</div>
            </div>
        </div>

        <div class="form-row">
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label for="invoice_number" class="">Numéro de facture</label>
                    <input name="invoice_number" id="invoice_number" placeholder="" type="text" class="form-control" v-model="$v.invoice.invoice_number.$model" readonly>
                    <small class="form-text text-danger" v-if="!$v.invoice.invoice_number.required">Champs requis.</small>
                </div>
            </div>
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label class="">Client</label>
                    <div class="bg-light pt-1 pl-2 pr-2 pb-1" style="border-radius: 5px">
                        <b>{{ invoice.customer.company_name }}</b><br>
                        {{ invoice.customer.phonenumber }}<br>
                        {{ invoice.customer.email }}<br>
                        {{ invoice.customer.address }}
                    </div>
                    <!--<select class="form-control" name="customer" id="customer" v-model="$v.invoice.customer_id.$model" disabled>-->
                        <!--<option value="">-&#45;&#45; Selectionnez un client s'il vous plait &#45;&#45;</option>-->
                        <!--<option v-for="customer in customers" v-bind:value="customer.id">{{ customer.company_name}}</option>-->
                    <!--</select>-->
                    <!--<small class="form-text text-danger" v-if="!$v.invoice.customer_id.required">Champs requis.</small>-->
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label for="title" class="">Titre de la facture</label>
                    <input name="title" id="title" placeholder="" type="text" class="form-control" v-model="$v.invoice.title.$model"
                        :readonly="invoice.is_paid || invoice.status == 1">
                    <small class="form-text text-danger" v-if="!$v.invoice.title.required">Champs requis.</small>
                </div>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Désignation</th>
                            <th>Prix Unitaire</th>
                            <th>Quantité</th>
                            <th>Montant HT</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="(item, index) in invoice.items" :key="index">
                            <td>
                                <textarea class="form-control" type="text" name="label" rows="1" v-model="item.label" :title="item.label"
                                      :readonly="invoice.is_paid || invoice.status == 1"></textarea>
                            </td>
                            <td>
                                <input class="form-control" type="number" name="pu" v-model="item.pu" v-on:input="editItem(item)"
                                   :readonly="invoice.is_paid || invoice.status == 1">
                            </td>
                            <td>
                                <input class="form-control" type="number" name="qty" v-model="item.qty" v-on:input="editItem(item)"
                                   :readonly="invoice.is_paid || invoice.status == 1">
                            </td>
                            <td>
                                <input class="form-control" type="number" name="amount" readonly v-model="item.amount">
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" @click="removeItem(index)" type="button" title="Retirer l'élément"
                                    v-if="invoice.items.length > 1 && !(invoice.is_paid || invoice.status == 1)">
                                    <i class="fa fa-times-circle"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="text-left">
                                <button class="btn btn-success btn-sm" @click="addItem()" type="button" title="Ajouter un élément"
                                    v-if="!(invoice.is_paid || invoice.status == 1)">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Montant Total HT</th>
                            <th colspan="1" class="text-right">{{ invoice.amount_et | numFormat }}</th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Remise (%)</th>
                            <th colspan="1" class="text-right">
                                <div class="row">
                                    <div class="col-md-6">
                                        <input class="form-control" type="number" name="amount" v-model="invoice.discount"
                                           v-on:input="calculateAmount" max="100" min="0" :readonly="invoice.is_paid || invoice.status == 1">
                                    </div>
                                    <div class="col-md-6">
                                        {{ ((invoice.amount_et * invoice.discount) /100) | numFormat }}
                                    </div>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Montant remisé</th>
                            <th colspan="1" class="text-right">
                                {{ invoice.amount_discount | numFormat }}
                            </th>
                        </tr>
                        <tr v-for="tax in selectedTaxes">
                            <th colspan="3" class="text-right">{{ tax.name }} ({{ tax.value }}%)</th>
                            <th colspan="1" class="text-right">{{ calculateTax(tax.value) | numFormat }}</th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Net à payer</th>
                            <th colspan="1" class="text-right bg-success text-light">{{ invoice.amount | numFormat }}</th>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="row" v-if="!invoice.is_paid && invoice.status == 0">
            <div class="col-md-12">
                <button type="button" class="mt-2 btn btn-primary" :disabled="$v.invoice.$invalid" @click="saveInvoice" v-if="!btnLoading">
                    <i class="fa fa-save"></i> Enregistrer
                </button>
                <button class="mt-2 btn btn-primary shadow-2" type="button" disabled="" v-if="btnLoading">
                    <span class="spinner-grow spinner-grow-sm" role="status"></span>
                    Traitement en cours
                </button>
                <button type="button" class="mt-2 btn btn-secondary" @click="selectTaxes">
                    Sélection des taxes
                </button>
            </div>
        </div>

        <!-- Modal pour ajouter les taxes au formulaire -->
        <modal name="select-taxes" height="auto">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Sélectionnez les taxes</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeModal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="position-relative form-group">
                        <div>
                            <div class="custom-checkbox custom-control" v-for="tax in taxes">
                                <input type="checkbox" class="custom-control-input" :id="'enabled'+tax.id" name="enabled"
                                   v-bind:checked="tax.enabled || includedTax(tax)"
                                   @change="clickTax(tax, $event)">
                                <label class="custom-control-label" :for="'enabled'+tax.id">{{ tax.name }} ({{ tax.value }})</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="closeModal">Fermer</button>
                </div>
            </div>
        </modal>

        <!--Modal pour ajouter un paiement-->
        <modal name="add-payment" height="80%">
            <div class="modal-content" style="box-sizing: border-box; height: 100%">
                <div class="modal-header" style="box-sizing: border-box;">
                    <h5 class="modal-title">Enregistrer paiement</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeModalPayment">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="box-sizing: border-box; height: calc(100% - 129px);overflow: auto">
                    <div class="form-group">
                        <label>Mode de paiement</label>
                        <select class="form-control" name="payment_method" v-model="$v.payment.payment_method_id.$model">
                            <option v-for="method in payment_methods" :value="method.id">{{ method.name }}</option>
                        </select>
                        <small class="form-text text-danger" v-if="!$v.payment.payment_method_id.required">Champs requis.</small>
                    </div>
                    <div class="form-group">
                        <label>Montant</label>
                        <input type="number" class="form-control" v-model="$v.payment.amount.$model" :max="invoice.amount_remaining"/>
                        <small class="form-text text-danger" v-if="!$v.payment.amount.required">Champs requis.</small>
                        <small class="form-text text-danger" v-if="!$v.payment.amount.minValue">Valuer minimale {{$v.payment.amount.$params.minValue.min}}.</small>
                    </div>
                    <label for="exampleFile" class="">
                        Pièces jointes
                    </label>
                    <div class="position-relative form-group" v-for="(document, index) in documents" :key="index">
                        <div class="row">
                            <div class="col-md-9">
                                <input name="file" id="exampleFile" type="file" class="form-control-file" :ref="'document'+index" @change="handleFileUpload(index)">
                            </div>
                            <div class="col-md-3">
                                <small class="form-text text-muted" v-if="documents.length > 1">
                                    <button class="border-0 btn-transition btn btn-outline-danger btn-sm" type="button" @click="removeDocument(index)">Retirer
                                    </button>
                                </small>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="border-0 btn-transition btn btn-outline-success btn-sm" @click="addDocument">Ajouter</button>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea class="form-control" v-model="$v.payment.description.$model"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="closeModalPayment">Fermer</button>
                    <button type="button" class="btn btn-success" @click="savePayment" :disabled="$v.payment.$invalid" v-if="!spinnerAddPayment">
                        Enregistrer
                    </button>
                    <button class="btn btn-primary shadow-2" type="button" disabled="" v-if="spinnerAddPayment">
                        <span class="spinner-grow spinner-grow-sm" role="status"></span>
                        Traitement en cours...
                    </button>
                </div>
            </div>
        </modal>

        <!--Modal pour historique des paiements-->
        <modal name="payment-history" height="auto">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Historique des paiements</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeModalHistory">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="mb-0 table table-striped">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Montant</th>
                            <th>Date</th>
                            <th>Description</th>
                            <th>Documents</th>
                            <th>Utilisateur</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-if="invoice.payments.length <= 0">
                            <td colspan="6" class="text-center">Aucun paiement</td>
                        </tr>
                        <tr v-for="payment in invoice.payments">
                            <th scope="row">{{ payment.id }}</th>
                            <td>{{ payment.amount }} XAF</td>
                            <td>{{ payment.created_at| moment("DD/MM/YYYY") }}</td>
                            <td>{{ payment.description }}</td>
                            <td>
                                <ul>
                                    <li v-for="document in payment.documents">
                                        <a :href="`/uploads/documents/payments/${document.url}`" target="_blank">{{ document.filename }}</a>
                                    </li>
                                </ul>
                            </td>
                            <td>{{ payment.user.name }}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </modal>

        <!-- Modal pour ajouter une recurrence -->
        <modal name="add-recurrence" height="auto">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ajouter Récurrence</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeModal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="position-relative form-group">
                        <label>Date de facturation</label>
                        <datepicker :input-class="'form-control'" v-model="$v.recurrence.date.$model" :format="'dd/MM/yyyy'"
                            :language="fr" :bootstrap-styling="true"></datepicker>
                        <small class="form-text text-danger" v-if="!$v.recurrence.date.required">Champs requis.</small>
                    </div>
                    <div class="position-relative form-group">
                        <label>Période</label>
                        <select class="form-control" v-model="$v.recurrence.period.$model">
                            <option value="month">Mois</option>
                            <option value="trimester">Trimestre</option>
                            <option value="year">Année</option>
                        </select>
                        <small class="form-text text-danger" v-if="!$v.recurrence.period.required">Champs requis.</small>
                    </div>
                    <div class="position-relative form-group">
                        <label>Occurence <i class="fa fa-exclamation-circle" title="Nombre de fois que la facture sera générée"></i></label>
                        <input type="number" class="form-control" v-model="$v.recurrence.occurence.$model"/>
                        <small class="form-text text-danger" v-if="!$v.recurrence.occurence.required">Champs requis.</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="closeModal">Fermer</button>
                    <button type="button" class="btn btn-success" @click="saveRecurrence" :disabled="$v.recurrence.$invalid" v-if="!spinnerRecurrence">
                        Enregistrer
                    </button>
                    <button class="btn btn-primary shadow-2" type="button" disabled="" v-if="spinnerRecurrence">
                        <span class="spinner-grow spinner-grow-sm" role="status"></span>
                        Traitement en cours...
                    </button>
                </div>
            </div>
        </modal>
    </form>

</template>

<script>
    import { required, minValue, maxValue } from 'vuelidate/lib/validators';
    import Datepicker from 'vuejs-datepicker';
    import {en, es, fr} from 'vuejs-datepicker/dist/locale'

    export default {
        props : ['customers', 'taxes', 'old_invoice', 'invoice_items', 'invoice_taxes', 'action', 'payment_methods'],
        components: {
            Datepicker
        },
        data(){
            return{
                fr: fr,
                invoice: {
                    invoice_number: '',
                    title: '',
                    customer_id: '',
                    items: [],
                    taxes: [],
                    amount_et: 0,
                    amount_discount: 0,
                    amount: 0,
                    discount: 0,
                    amount_taxes: 0,
                    selected_taxes: [],
                    payments: [],
                    documents: [],
                    amount_paid: 0,
                    amount_remaining: 0,
                    is_paid: null,
                    customer: {},
                    deadline: {}
                },
                documents: [],
                payment: {
                    payment_method_id: '',
                    amount: 0,
                    description: ''
                },
                recurrence: {
                    date: null,
                    period: 'month',
                    occurence: 1
                },
                spinner: false,
                spinnerAddPayment: false,
                spinnerRecurrence: false,
                csrfToken: null,
                api_token: '',
                selectedTaxes: [],
                btnLoading: false

            }
        },
        validations: {
            invoice: {
                invoice_number: {
                    required
                },
                customer_id: {
                    required
                },
                title: {
                    required
                }

            },
            payment: {
                payment_method_id: {
                    required
                },
                amount: {
                    required,
                    minValue: minValue(100),
                    // maxValue: maxValue(this.invoice.amount_remaining)
                },
                description: {
                    // required
                },
            },
            recurrence: {
                date: {
                    required
                },
                period: {
                    required
                },
                occurence: {
                    required
                }
            },
        },
        mounted() {
            // $("#country").select2({placeholder:"Sélectionnez un pays"})
            // $("#city").select2({placeholder:"Sélectionnez une ville"})
        },
        created(){
            if (window.localStorage.getItem('authUser')) {
                const authCustomer = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authCustomer.api_token
            }

            this.csrfToken = document.querySelector('meta[name="csrf-token"]').content

            this.initTaxes()
            this.invoice.id = this.old_invoice.id;
            this.invoice.payments = [];
            this.fetchInvoice();
            this.invoice.items = [...this.invoice_items];
            this.selectedTaxes = [...this.invoice_taxes];
        },

        methods: {
            fetchInvoice() {
                let page_url = `/api/invoice/${this.invoice.id}?api_token=${this.api_token}`;

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.invoice = res.data
                    })
                    .catch(error => {
                        this.$swal({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Erreur chargement des données!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    });
            },
            addItem(){
                this.invoice.items.push({
                    id: 0,
                    label: '',
                    pu: 0,
                    qty: 0,
                    amount: 0,
                    created_at: '',
                    updated_at: ''
                })
                this.calculateAmount()
            },
            removeItem(index){
                this.invoice.items.splice(index, 1)
                this.calculateAmount()
            },
            saveInvoice(){
                this.spinner = true
                this.invoice.selected_taxes = this.selectedTaxes
                fetch(`/api/invoice?api_token=${this.api_token}`, {
                    method: 'PUT',
                    body: JSON.stringify(this.invoice),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.invoice = res.data;
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Facture enregistrée!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    })
                    .catch(error => {
                        this.spinner = false
                        this.$swal({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Erreur traitement!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    });
            },
            editItem(item){
                item.amount =  item.pu * item.qty
                this.calculateAmount()
            },
            initTaxes(){
                this.taxes.forEach(tax =>{
                    if(tax.enabled === true){
                        this.selectedTaxes.push(tax)
                    }
                })
            },
            closeModal(){
                this.$modal.hide('select-taxes');
                this.$modal.hide('add-recurrence');
                this.recurrence =  {
                    date: new Date(),
                    period: 'month',
                    occurence: 1
                }
            },
            selectTaxes(){
                this.$modal.show('select-taxes')

            },
            clickTax(tax, event){
                let index = this.selectedTaxes.findIndex(x => x.id === tax.id);

                if(event.target.checked) {
                    this.selectedTaxes.push(tax)
                    tax.enabled = true
                }
                if(!event.target.checked){
                    this.selectedTaxes.splice(index, 1)
                    tax.enabled = false
                }

                this.calculateAmount()
            },
            calculateTax(value){
                // let amountWithdiscount = this.invoice.amount_et - this.invoice.discount
                return (this.invoice.amount_discount * value)/100
            },
            calculateAmount(){
                this.invoice.amount_et = 0
                this.invoice.amount = 0
                this.invoice.items.forEach(res=>{
                    this.invoice.amount_et += res.amount
                })
                this.invoice.amount_discount = this.invoice.amount_et - (this.invoice.amount_et * this.invoice.discount)/100

                this.invoice.amount_taxes = 0
                this.selectedTaxes.forEach(item=>{
                    this.invoice.amount_taxes += this.calculateTax(item.value)
                })

                this.invoice.amount = this.invoice.amount_discount + this.invoice.amount_taxes
            },
            includedTax(tax){
                let index = this.selectedTaxes.findIndex(x => x.id === tax.id);

                if(index !== -1) return true
                else return false
            },
            printInvoice(id){
                window.open(`/invoice/print/${id}`, '_blank');
            },
            validateInvoice(){
                this.invoice.status = 1;
                this.saveInvoice();
            },
            addDocument(){
                this.documents.push(new File([""], "filename"));
                this.$forceUpdate();
            },
            removeDocument(index){
                this.documents.splice(index, 1);
                this.$forceUpdate();
                console.log(this.documents);
            },
            handleFileUpload(index){
                this.documents[index] = this.$refs['document'+index][0].files[0];
                this.$forceUpdate();
            },
            closeModalPayment(){
                this.payment = {
                    payment_method_id: '',
                    amount: 0,
                    description: ''
                };
                this.documents = [];
                this.$modal.hide('add-payment');
                this.$forceUpdate();
            },
            addModalPayment(){
                this.addDocument();
                this.payment.amount = this.invoice.amount_remaining;
                this.$modal.show('add-payment');
                this.$forceUpdate();
            },
            savePayment(){
                this.spinnerAddPayment = true
                this.payment.invoice_id = this.invoice.id;

                let formData = new FormData();
                for(var key in this.payment){
                    formData.append(key, this.payment[key]);
                }
                this.documents.forEach((el, index) =>{
                    if(el.size > 0) formData.append(`documents[${index}]`, el)
                });

                fetch(`/api/payment?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: formData
                    // body: JSON.stringify(this.payment),
                    // headers: {
                    //     'content-type': 'application/json'
                    // }
                })
                    .then(res => res.json())
                    .then(res => {
                        this.invoice = res.data;

                        this.spinnerAddPayment = false;
                        this.closeModalPayment();
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Paiement enregistré!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })


                    })
                    .catch(error => {
                        this.spinnerAddPayment = false;
                        this.$swal({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Erreur traitement!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    });
            },
            openModalHistory(){
                this.$modal.show('payment-history');
            },
            closeModalHistory(){
                this.$modal.hide('payment-history');
            },
            sendEmail(){
                this.spinner = true
                fetch(`/api/invoice/send-email?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: JSON.stringify(this.invoice),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        // this.invoice = res.data;
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'E-mail envoyé!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    })
                    .catch(error => {
                        this.spinner = false
                        this.$swal({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Erreur d\'envoi du mail!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    });
            },
            deleteInvoice(id){
                let vm = this;

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`/api/invoice/${id}?api_token=${this.api_token}`, { method: 'delete' })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error(response.statusText)
                                }
                                return response.json()
                            })
                            .catch(error => {
                                this.$swal.showValidationMessage(
                                    `Request failed: ${error}`
                                )
                            })
                    },
                    allowOutsideClick: () => !this.$swal.isLoading()
                }).then((result) => {
                    if (result.value) {
                        this.$swal({
                            position: 'top-end',
                            icon: 'warning',
                            title: 'Cette facture a été supprimée',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                        window.location = '/invoices';
                    }
                })

            },
            duplicateInvoice(id){
                window.location = `/invoice/duplicate/${id}`;
            },
            convertInvoice(id){
                window.location = `/credit-note/create?i=${id}`;
            },
            addRecurrence(){
                this.$modal.show('add-recurrence')
            },
            saveRecurrence(){
                this.spinnerRecurrence = true
                this.recurrence.invoice_id = this.invoice.id;

                fetch(`/api/invoice/add-recurrence?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: JSON.stringify(this.recurrence),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        this.invoice = res.data;

                        this.spinnerRecurrence = false;
                        this.closeModal();
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Récurrence enregistré!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })


                    })
                    .catch(error => {
                        this.spinnerRecurrence = false;
                        this.$swal({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Erreur traitement!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    });
            }


        }

    }
</script>
