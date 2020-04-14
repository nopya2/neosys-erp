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
                        <button class="dropdown-item" type="button" @click="billPurchaseOrder(purchase_order.id)" :disabled="purchase_order.status === 'billed'">
                            <i class="fa fa-file"></i>&nbsp;Facturer
                        </button>
                        <div class="dropdown-divider"></div>
                        <button class="dropdown-item" type="button" @click="printPurchaseOrder(purchase_order.id)">
                            <i class="fa fa-print"></i>&nbsp;Imprimer
                        </button>
                        <button type="button" tabindex="0" class="dropdown-item" @click="printPurchaseOrder(purchase_order.id)" :disabled="purchase_order.status === 'billed' || purchase_order.status === 'canceled'">
                            <i class="fa fa-print"></i>&nbsp;Imprimer bon de commande
                        </button>
                        <button type="button" class="dropdown-item" @click="sendEmail()">
                            <i class="fa fa-envelope"></i>&nbsp;Envoyer
                        </button>
                        <div class="dropdown-divider"></div>
                        <button type="button" class="dropdown-item" @click="duplicatePurchaseOrder(purchase_order.id)">
                            <i class="fa fa-clone"></i>&nbsp;Dupliquer
                        </button>
                        <button type="button" class="dropdown-item text-danger" :disabled="purchase_order.status === 'billed'" @click="deletePurchaseOrder(purchase_order.id)">
                            <i class="fa fa-trash"></i>&nbsp;Supprimer
                        </button>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="mb-2 mr-2 badge badge-dark float-right" v-if="purchase_order.status === 'canceled'">Expiré</div>
                <div class="mb-2 mr-2 badge badge-success float-right" v-if="purchase_order.status === 'billed'">Facturé</div>
                <div class="mb-2 mr-2 float-right" v-if="purchase_order.status === 'in_progress'">
                    {{ purchase_order.deadline.d }} jour(s) restant
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label for="purchase_order_number" class="">Numéro de commande</label>
                    <input name="purchase_order_number" id="purchase_order_number" placeholder="" type="text" class="form-control form-control-sm" v-model="$v.purchase_order.purchase_order_number.$model" readonly>
                    <small class="form-text text-danger" v-if="!$v.purchase_order.purchase_order_number.required">Champs requis.</small>
                </div>
            </div>
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label class="">Client</label>
                    <div class="bg-light pt-1 pl-2 pr-2 pb-1" style="border-radius: 5px">
                        <b>{{ purchase_order.customer.company_name }}</b><br>
                        {{ purchase_order.customer.phonenumber }}<br>
                        {{ purchase_order.customer.email }}<br>
                        {{ purchase_order.customer.address }}
                    </div>
                    <!--<select class="form-control" name="customer" id="customer" v-model="$v.purchase_order.customer_id.$model" disabled>-->
                        <!--<option value="">-&#45;&#45; Selectionnez un client s'il vous plait &#45;&#45;</option>-->
                        <!--<option v-for="customer in customers" v-bind:value="customer.id">{{ customer.company_name}}</option>-->
                    <!--</select>-->
                    <!--<small class="form-text text-danger" v-if="!$v.purchase_order.customer_id.required">Champs requis.</small>-->
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label for="title" class="">Titre de la commande</label>
                    <input name="title" id="title" placeholder="" type="text" class="form-control form-control-sm" v-model="$v.purchase_order.title.$model" :readonly="purchase_order.expired || purchase_order.is_billed">
                    <small class="form-text text-danger" v-if="!$v.purchase_order.title.required">Champs requis.</small>
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
                        <tr v-for="(item, index) in purchase_order.items" :key="index">
                            <td>
                                <textarea class="form-control form-control-sm" type="text" name="label" rows="1" v-model="item.label" :readonly="purchase_order.status === 'billed'"></textarea>
                            </td>
                            <td>
                                <input class="form-control form-control-sm" type="number" name="pu" v-model="item.pu" v-on:input="editItem(item)" :readonly="purchase_order.status === 'billed'">
                            </td>
                            <td>
                                <input class="form-control form-control-sm" type="number" name="qty" v-model="item.qty" v-on:input="editItem(item)" :readonly="purchase_order.status === 'billed'">
                            </td>
                            <td>
                                <input class="form-control form-control-sm" type="number" name="amount" readonly v-model="item.amount">
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" @click="removeItem(index)" type="button" title="Retirer l'élément"
                                    v-if="purchase_order.items.length > 1 && purchase_order.status !== 'billed'">
                                    <i class="fa fa-times-circle"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="text-left">
                                <button class="btn btn-success btn-sm" @click="addItem()" type="button" title="Ajouter un élément" v-if="purchase_order.status !== 'billed'">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Montant Total HT</th>
                            <th colspan="1" class="text-right">{{ purchase_order.amount_et | numFormat }}</th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Remise (%)</th>
                            <th colspan="1" class="text-right">
                                <div class="row">
                                    <div class="col-md-6">
                                        <input class="form-control" type="number" name="amount" v-model="purchase_order.discount"
                                               v-on:input="calculateAmount" max="100" min="0" :readonly="purchase_order.status === 'billed'">
                                    </div>
                                    <div class="col-md-6">
                                        {{ ((purchase_order.amount_et * purchase_order.discount) /100) | numFormat }}
                                    </div>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Montant remisé</th>
                            <th colspan="1" class="text-right">
                                {{ purchase_order.amount_discount | numFormat }}
                            </th>
                        </tr>
                        <tr v-for="tax in selectedTaxes">
                            <th colspan="3" class="text-right">{{ tax.name }} ({{ tax.value }}%)</th>
                            <th colspan="1" class="text-right">{{ calculateTax(tax.value) | numFormat }}</th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Net à payer</th>
                            <th colspan="1" class="text-right bg-success text-light">{{ purchase_order.amount | numFormat }}</th>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="row" v-if="purchase_order.status !== 'billed'">
            <div class="col-md-12">
                <button type="button" class="mt-2 btn btn-primary" :disabled="$v.purchase_order.$invalid" @click="savePurchaseOrder" v-if="!btnLoading">
                    <i class="fa fa-save"></i> Enregistrer
                </button>
                <button class="mt-2 btn btn-primary shadow-2" type="button" disabled="" v-if="btnLoading">
                    <span class="spinner-grow spinner-grow-sm" role="status"></span>
                    Traitement en cours
                </button>
                <button type="button" class="mt-2 btn btn-danger" :disabled="$v.purchase_order.$invalid || btnLoading" onclick="window.history.back();" v-if="action === 'reedit'">
                    <i class="fa fa-save"></i> Annuler la réédition
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
    </form>

</template>

<script>
    import { required, minLength } from 'vuelidate/lib/validators'

    export default {
        props : ['customers', 'taxes', 'old_purchase_order', 'purchase_order_items', 'purchase_order_taxes', 'action'],
        data(){
            return{
                purchase_order: {
                    purchase_order_number: '',
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
                    deadline: {
                        d: null
                    },
                    customer: {}
                },
                spinner: false,
                csrfToken: null,
                api_token: '',
                selectedTaxes: [],
                btnLoading: false

            }
        },
        validations: {
            purchase_order: {
                purchase_order_number: {
                    required
                },
                customer_id: {
                    required
                },
                title: {
                    required
                },
                items:{
                    required,
                    minLength: minLength(1),
                    $each: {
                        label: {
                            required,
                            minLength: minLength(2)
                        },
                        pu: {
                            required,
                        },
                        qty: {
                            required
                        }

                    }
                }

            }
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
            this.purchase_order.id = this.old_purchase_order.id;
            this.fetchPurchaseOrder();
            this.purchase_order.items = [...this.purchase_order_items]
            this.selectedTaxes = [...this.purchase_order_taxes]
        },

        methods: {
            fetchPurchaseOrder() {
                let page_url = `/api/purchase-orders/${this.purchase_order.id}?api_token=${this.api_token}`;
                this.spinner = true;

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false;
                        this.purchase_order = res.data
                    })
                    .catch(error => {
                        this.spinner = false;
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
                this.purchase_order.items.push({
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
                this.purchase_order.items.splice(index, 1)
                this.calculateAmount()
            },
            savePurchaseOrder(){
                this.btnLoading = true
                this.purchase_order.selected_taxes = this.selectedTaxes
                fetch(`/api/purchase-orders/${this.purchase_order.id}?api_token=${this.api_token}&action=${this.action}`, {
                    method: 'PUT',
                    body: JSON.stringify(this.purchase_order),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        this.btnLoading = false
                        this.purchase_order = res.data;
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Commande enregistrée!',
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
                // let amountWithdiscount = this.purchase_order.amount_et - this.purchase_order.discount
                return (this.purchase_order.amount_discount * value)/100
            },
            calculateAmount(){
                this.purchase_order.amount_et = 0
                this.purchase_order.amount = 0
                this.purchase_order.items.forEach(res=>{
                    this.purchase_order.amount_et += res.amount
                })
                this.purchase_order.amount_discount = this.purchase_order.amount_et - (this.purchase_order.amount_et * this.purchase_order.discount)/100

                this.purchase_order.amount_taxes = 0
                this.selectedTaxes.forEach(item=>{
                    this.purchase_order.amount_taxes += this.calculateTax(item.value)
                })

                this.purchase_order.amount = this.purchase_order.amount_discount + this.purchase_order.amount_taxes
            },
            includedTax(tax){
                let index = this.selectedTaxes.findIndex(x => x.id === tax.id);

                if(index !== -1) return true
                else return false
            },
            printPurchaseOrder(id){
                window.open(`/purchase-order/print/${id}`, '_blank');
            },
            billPurchaseOrder(id){
                this.$swal({
                    title: 'Facturer',
                    text: 'Etes-vous sur de vouloir facturer cette commande?',
                    showCancelButton: true,
                    confirmButtonText: 'Facturer',
                    confirmButtonColor: '#28A745',
                    // showLoaderOnConfirm: true,
                }).then((result) => {
                    if (result.value) {
                        window.location = `/purchase_order/bill/${id}`;
                    }
                })
            },
            duplicatePurchaseOrder(id){
                this.$swal({
                    title: 'Dupliquer',
                    text: 'Etes-vous sur de vouloir dupliquer cette commande?',
                    showCancelButton: true,
                    confirmButtonText: 'Dupliquer',
                    confirmButtonColor: '#28A745',
                    // showLoaderOnConfirm: true,
                }).then((result) => {
                    if (result.value) {
                        window.location = `/purchase-order/duplicate/${id}`;
                    }
                })
            },
            deletePurchaseOrder(id){
                let vm = this;

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`/api/purchase_order/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                            title: 'Cette commande a été supprimée',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                        window.location = '/purchase-orders';
                    }
                })

            },
            sendEmail(){
                this.spinner = true
                fetch(`/api/purchase-order/send-email?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: JSON.stringify(this.purchase_order),
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
            printPurchaseOrder(id){
                window.open(`/purchase-order/print/${id}`, '_blank');
            }


        }

    }
</script>
