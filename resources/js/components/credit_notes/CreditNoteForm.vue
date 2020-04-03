<template>
    <form class="">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>N° de facture</label>
                    <input type="text" class="form-control" name="invoice_number" readonly :value="invoice.invoice_number">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label>Montant</label>
                    <input type="text" class="form-control" name="amount" readonly :value="invoice.amount|numFormat">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>Client</label>
                    <div class="bg-light pt-1 pl-2 pr-2 pb-1" style="border-radius: 5px">
                        <b>{{ invoice.customer.company_name }}</b><br>
                        {{ invoice.customer.phonenumber }}<br>
                        {{ invoice.customer.email }}<br>
                        {{ invoice.customer.address }}
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>Type facture d'avoir</label>
                <select class="form-control" v-model="$v.credit_note.type.$model" @change="calculateAmount()">
                    <option value="1">Avoir commercial</option>
                    <option value="2">Retour marchandise ou annulation prestation</option>
                    <option value="3">Erreur de facturation</option>
                </select>
                <small class="form-text text-danger" v-if="!$v.credit_note.type.required">Champs requis.</small>
            </div>
            <div class="col-md-6" v-if="this.credit_note.type == 1">
                <div class="row">
                    <div class="col-md-5">
                        <label>Remise en %</label>
                        <input type="number" max="100" class="form-control" name="percent_discount" v-model="$v.credit_note.percent_discount.$model"
                           v-on:input="calculateAmount()">
                    </div>
                    <div class="col-md-2 text-center">ou</div>
                    <div class="col-md-5">
                        <label>Montant à déduire</label>
                        <input type="number" class="form-control" name="amount_discount" v-model="$v.credit_note.amount_discount.$model"
                            :max="invoice.amount" v-on:input="calculateAmount()">
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-md-12">
                <button class="btn btn-success btn-lg float-right" type="button">Montant de la facture d'avoir: {{ credit_note.amount|numFormat }}</button>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-md-12">
                <button type="button" class="btn btn-success" @click="convertInvoice" :disabled="$v.credit_note.$invalid || credit_note.amount <= 0" v-if="!spinner">
                    Convertir
                </button>
                <button type="button" class="btn btn-danger" @click="cancel" :disabled="spinner">
                    Annuler
                </button>
                <button class="btn btn-primary shadow-2" type="button" disabled="" v-if="spinner">
                    <span class="spinner-grow spinner-grow-sm" role="status"></span>
                    Conversion en cours...
                </button>
            </div>
        </div>
    </form>
</template>

<script>
    import { required, minValue, maxValue } from 'vuelidate/lib/validators'

    export default {
        props : ['invoice_id'],
        data(){
            return{
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
                    payments: [],
                    amount_paid: 0,
                    amount_remaining: 0,
                    is_paid: null,
                    customer: {},
                    deadline: {}
                },
                credit_note: {
                    invoice_id: null,
                    type: null,
                    percent_discount: 5,
                    amount_discount: 5000,
                    amount: 0
                },
                spinner: false,
                csrfToken: null,
                api_token: '',
                btnLoading: false

            }
        },
        validations: {
            credit_note: {
                type: {
                    required
                },
                percent_discount: {

                },
                amount_discount: {

                },
                amount: {

                }
            }
        },
        mounted() {
        },
        created(){
            if (window.localStorage.getItem('authUser')) {
                const authCustomer = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authCustomer.api_token
            }

            this.csrfToken = document.querySelector('meta[name="csrf-token"]').content
            this.invoice.id = this.invoice_id;
            this.fetchInvoice();
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
            convertInvoice(){
                this.spinner = true;
                this.credit_note.invoice_id = this.invoice.id;
                fetch(`/api/credit-note?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: JSON.stringify(this.credit_note),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        window.history.back();
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: "Facture convertie en facture d'avoir!",
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
            calculateAmount(){
                this.credit_note.amount = 0;
                if(this.credit_note.type == 1){
                    this.credit_note.amount = this.invoice.amount - (this.credit_note.percent_discount * this.invoice.amount) / 100 - this.credit_note.amount_discount;
                }else{
                    this.credit_note.percent_discount = 0;
                    this.credit_note.amount_discount = 0;
                    this.credit_note.amount = this.invoice.amount;
                }
            },
            cancel(){
                window.history.back();
            }

        }

    }
</script>
