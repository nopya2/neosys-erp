<template>
    <form class="">
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
                    <label for="customer" class="">Client</label>
                    <select class="form-control" name="customer" id="customer" v-model="$v.invoice.customer_id.$model">
                        <option value="">--- Selectionnez un client s'il vous plait --</option>
                        <option v-for="customer in customers" v-bind:value="customer.id">{{ customer.company_name}}</option>
                    </select>
                    <small class="form-text text-danger" v-if="!$v.invoice.customer_id.required">Champs requis.</small>
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label for="title" class="">Titre de la facture</label>
                    <input name="title" id="title" placeholder="" type="text" class="form-control" v-model="$v.invoice.title.$model">
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
                                <textarea class="form-control" type="text" name="label" rows="1" v-model="item.label"></textarea>
                            </td>
                            <td>
                                <input class="form-control" type="number" name="pu" v-model="item.pu" v-on:input="editItem(item)">
                            </td>
                            <td>
                                <input class="form-control" type="number" name="qty" v-model="item.qty" v-on:input="editItem(item)">
                            </td>
                            <td>
                                <input class="form-control" type="number" name="amount" readonly v-model="item.amount">
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" @click="removeItem(index)" type="button" title="Retirer l'élément"
                                    v-if="invoice.items.length > 1">
                                    <i class="fa fa-times-circle"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="text-left">
                                <button class="btn btn-success btn-sm" @click="addItem()" type="button" title="Ajouter un élément">
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
                                           v-on:input="calculateAmount" max="100" min="0">
                                    </div>
                                    <div class="col-md-6">
                                        {{ ((invoice.amount_et * invoice.discount) /100) | numFormat  }}
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

        <div class="row">
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
                                <input type="checkbox" class="custom-control-input" :id="'enabled'+tax.id" name="enabled" v-bind:checked="tax.enabled"
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
    import { required } from 'vuelidate/lib/validators'

    export default {
        props : ['customers', 'invoice_number', 'taxes'],
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
                    selected_taxes: []
                },
                spinner: false,
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

            this.invoice.invoice_number = this.invoice_number
            this.addItem()
            this.initTaxes()
        },

        methods: {
            addItem(){
                this.invoice.items.push({
                    label: '',
                    pu: 0,
                    qty: 0,
                    amount: 0,
                })
            },
            removeItem(index){
                this.invoice.items.splice(index, 1)
                this.calculateAmount()
            },
            saveInvoice(){
                this.btnLoading = true
                this.invoice.selected_taxes = this.selectedTaxes

                console.log(this.invoice);

                fetch(`/api/invoice?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: JSON.stringify(this.invoice),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        this.btnLoading = false
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Facture enregistrée!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })

                        window.location = `/invoice/${res.data.id}/edit`
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


            }


        }

    }
</script>
