<template>
    <form class="">
        <div class="form-row">
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label>Client <i class="fa fa-plus-circle text-success" style="cursor: pointer" @click="addCustomer"></i></label>
                    <v-select :options="customers" label="company_name" index="id" :filterable="false" @search="onSearch" v-model="$v.quote.customer_id.$model"
                        :reduce="company_name => company_name.id">
                        <template slot="no-options">
                            Aucun client trouvé
                        </template>
                        <template slot="option" slot-scope="option">
                            <div class="d-center">
                                {{ option.company_name }}
                            </div>
                        </template>
                        <template slot="selected-option" slot-scope="option">
                            <div class="selected d-center">
                                {{ option.company_name }}
                            </div>
                        </template>
                    </v-select>
                    <small class="form-text text-danger" v-if="!$v.quote.customer_id.required">Champs requis.</small>
                </div>
            </div>
            <div class="col-md-6">
                <div class="position-relative form-group">
                    <label for="title" class="">Titre du devis</label>
                    <input name="title" id="title" placeholder="" type="text" class="form-control form-control-sm" v-model="$v.quote.title.$model">
                    <small class="form-text text-danger" v-if="!$v.quote.title.required">Champs requis.</small>
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
                        <tr v-for="(item, index) in quote.items" :key="index">
                            <td>
                                <textarea class="form-control form-control-sm" type="text" name="label" rows="1" v-model="item.label"></textarea>
                            </td>
                            <td>
                                <input class="form-control form-control-sm" type="number" name="pu" v-model="item.pu" v-on:input="editItem(item)">
                            </td>
                            <td>
                                <input class="form-control form-control-sm" type="number" name="qty" v-model="item.qty" v-on:input="editItem(item)">
                            </td>
                            <td>
                                <input class="form-control form-control-sm" type="number" name="amount" readonly v-model="item.amount">
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" @click="removeItem(index)" type="button" title="Retirer l'élément"
                                    v-if="quote.items.length > 1">
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
                            <th colspan="1" class="text-right">{{ quote.amount_et | numFormat }}</th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Remise (%)</th>
                            <th colspan="1" class="text-right">
                                <div class="row">
                                    <div class="col-md-6">
                                        <input class="form-control" type="number" name="amount" v-model="quote.discount"
                                           v-on:input="calculateAmount" max="100" min="0">
                                    </div>
                                    <div class="col-md-6">
                                        {{ ((quote.amount_et * quote.discount) /100) | numFormat  }}
                                    </div>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Montant remisé</th>
                            <th colspan="1" class="text-right">
                                {{ quote.amount_discount | numFormat }}
                            </th>
                        </tr>
                        <tr v-for="tax in selectedTaxes">
                            <th colspan="3" class="text-right">{{ tax.name }} ({{ tax.value }}%)</th>
                            <th colspan="1" class="text-right">{{ calculateTax(tax.value) | numFormat }}</th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Net à payer</th>
                            <th colspan="1" class="text-right bg-success text-light">{{ quote.amount | numFormat }}</th>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <button type="button" class="mt-2 btn btn-primary" :disabled="$v.quote.$invalid" @click="saveQuote" v-if="!btnLoading">
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
        props : ['taxes'],
        data(){
            return{
                quote: {
                    title: '',
                    customer_id: null,
                    items: [],
                    taxes: [],
                    amount_et: 0,
                    amount_discount: 0,
                    amount: 0,
                    discount: 0,
                    amount_taxes: 0,
                    selected_taxes: []
                },
                customers: [],
                spinner: false,
                csrfToken: null,
                api_token: '',
                selectedTaxes: [],
                btnLoading: false

            }
        },
        validations: {
            quote: {
                customer_id: {
                    required
                },
                title: {
                    required
                }

            }
        },
        mounted() {
        },
        created(){
            if (window.localStorage.getItem('authUser')) {
                const auth_user = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = auth_user.api_token
            }

            this.csrfToken = document.querySelector('meta[name="csrf-token"]').content
            this.addItem()
            this.initTaxes()
        },

        methods: {
            addItem(){
                this.quote.items.push({
                    label: '',
                    pu: 0,
                    qty: 0,
                    amount: 0,
                })
            },
            removeItem(index){
                this.quote.items.splice(index, 1)
                this.calculateAmount()
            },
            saveQuote(){
                this.btnLoading = true
                this.quote.selected_taxes = this.selectedTaxes
                fetch(`/api/quote?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: JSON.stringify(this.quote),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    // .then(res => res.json())
                    .then(res => {
                        this.btnLoading = false
                        if (res.ok){
                            res.json().then(result =>{
                                this.$swal({
                                    position: 'top-end',
                                    icon: 'success',
                                    title: 'Devis enregistré!',
                                    showConfirmButton: false,
                                    timer: 5000,
                                    toast: true
                                })

                                window.location = `/quote/${result.data.id}/edit`
                            })

                        }else{
                            res.json().then(error =>{
                                this.$swal({
                                    position: 'top-end',
                                    icon: 'error',
                                    title: error.errorInfo[2],
                                    showConfirmButton: false,
                                    timer: 5000,
                                    toast: true
                                })
                            })

                        }

                    })
                    .catch(error => {
                        console.log(error);
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
                // let amountWithdiscount = this.quote.amount_et - this.quote.discount
                return (this.quote.amount_discount * value)/100
            },
            calculateAmount(){
                this.quote.amount_et = 0
                this.quote.amount = 0
                this.quote.items.forEach(res=>{
                    this.quote.amount_et += res.amount
                })
                this.quote.amount_discount = this.quote.amount_et - (this.quote.amount_et * this.quote.discount)/100

                this.quote.amount_taxes = 0
                this.selectedTaxes.forEach(item=>{
                    this.quote.amount_taxes += this.calculateTax(item.value)
                })

                this.quote.amount = this.quote.amount_discount + this.quote.amount_taxes


            },
            addCustomer(){
                window.open('/customer/create?action=quote', 'customer', "height=600,width=600,modal=yes,alwaysRaised=yes");
            },
            onSearch(search, loading) {
                loading(true);
                this.search(loading, search, this);
            },
            search(loading, search, vm){
                fetch(`/api/customers/select?api_token=${this.api_token}&search=${search}`)
                    .then(res => res.json())
                    .then(res => {
                        loading(false);
                        vm.customers = res.data
                    })
                    .catch(error => {
                        loading(false);
                        console.log(error)
                    });
            }
        }

    }
</script>
