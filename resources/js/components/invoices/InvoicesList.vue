<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <button type="button" class="btn btn-success btn-sm" @click="create">
                        <i class="fa fa-plus-circle"></i> Nouvelle facture
                    </button>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label>Statut</label>
                        <select class="form-control form-control-sm" v-model="filter.status" @change="search">
                            <option value="0">Tout</option>
                            <option value="1">Brouillon</option>
                            <option value="2">En retard</option>
                            <option value="3">En cours</option>
                            <option value="4">Payé</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label>N° de facture ou Client</label>
                        <input type="text" class="form-control form-control-sm" placeholder="Tapez votre recherche" aria-label="Recipient's customername"
                               aria-describedby="basic-addon2" v-model="keyword" v-on:input="search">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="table-border-style">
                        <div class="d-flex justify-content-center mb-3" v-if="spinner">
                            <div class="spinner-grow text-warning" role="status">
                                <span class="sr-only">Loading...</span>
                            </div>
                        </div>
                        <div>
                            {{ pagination.total }} Facture(s)
                        </div>
                        <div class="table-responsive" style="min-height: 450px;">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>N&deg; de facture</th>
                                    <th>Intitulé</th>
                                    <th>Client</th>
                                    <th>Type</th>
                                    <th>Montant</th>
                                    <th>Date</th>
                                    <!--<th>Expire</th>-->
                                    <th>Statut</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-if="invoices.length <= 0">
                                    <td colspan="9" class="text-center">Aucune facture</td>
                                </tr>
                                <tr v-for="invoice in invoices" style="font-size: 13px" v-bind:class="{'bg-info': selected == invoice.id }" @click="selected = invoice.id">
                                    <td>
                                        <div class="dropdown d-inline-block">
                                            <button type="button" aria-haspopup="true" aria-expanded="false" data-toggle="dropdown"
                                                    class="dropdown-toggle btn btn-primary btn-sm" id="dropdownMenuButton">{{ invoice.id }}</button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                <button type="button" tabindex="0" class="dropdown-item" @click="openInvoice(invoice.id,'edit')" v-if="invoice.status === 'draft'">
                                                    <i class="fa fa-edit"></i>&nbsp;Editer
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item" @click="openInvoice(invoice.id,'edit')" v-if="invoice.status !== 'draft'">
                                                    <i class="fa fa-eye"></i>&nbsp;Détails
                                                </button>
                                                <button type="button" class="dropdown-item" @click="validateInvoice(invoice)" v-if="invoice.status == 'draft'">
                                                    <i class="fa fa-check"></i>&nbsp;Valider
                                                </button>
                                                <div class="dropdown-divider"></div>
                                                <button type="button" class="dropdown-item" @click="convertInvoice(invoice.id)" :disabled="invoice.status == 0 || invoice.amount_paid > 0">
                                                    <i class="fa fa-file"></i>&nbsp;Convertir en facture d'avoir
                                                </button>
                                                <button type="button" class="dropdown-item" :disabled="invoice.status == 0" @click="addRecurrence" v-if="!invoice.recurrence">
                                                    <i class="fa fa-clock"></i>&nbsp;Récurrence
                                                </button>
                                                <button type="button" class="dropdown-item" @click="cancelRecurrence" v-if="invoice.recurrence">
                                                    <i class="fa fa-clock"></i>&nbsp;Annuler la Récurrence
                                                </button>
                                                <div class="dropdown-divider"></div>
                                                <button type="button" class="dropdown-item" :disabled="invoice.status == 0" @click="printInvoice(invoice.id)">
                                                    <i class="fa fa-print"></i>&nbsp;Imprimer
                                                </button>
                                                <button type="button" class="dropdown-item" :disabled="invoice.status == 0" @click="sendEmail()">
                                                    <i class="fa fa-envelope"></i>&nbsp;Envoyer
                                                </button>
                                                <!--<div class="dropdown-divider"></div>-->
                                                <!--<button type="button" class="dropdown-item" :disabled="invoice.status == 0" disabled>-->
                                                    <!--<i class="fa fa-print"></i>&nbsp;Imprimer bon de livraison-->
                                                <!--</button>-->
                                                <div class="dropdown-divider"></div>
                                                <button type="button" class="dropdown-item" @click="duplicateInvoice(invoice.id)">
                                                    <i class="fa fa-clone"></i>&nbsp;Dupliquer
                                                </button>
                                                <button type="button" class="dropdown-item" :disabled="invoice.status == 1" @click="deleteInvoice(invoice.id)">
                                                    <i class="fa fa-trash"></i>&nbsp;Supprimer
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                    <td>{{ invoice.invoice_number }}</td>
                                    <td>{{ invoice.title }}</td>
                                    <td>{{ invoice.customer.company_name }}<br>
                                        <i class="fa fa-phone"></i> {{ invoice.customer.phonenumber }}
                                    </td>
                                    <td>
                                        {{ invoice.show_type }}
                                    </td>
                                    <td class="text-center">
                                        <div class="mb-2 mr-2 badge badge-info">{{ invoice.amount|numFormat }}</div>
                                    </td>
                                    <td class="text-center">{{ invoice.updated_at| moment("DD/MM/YYYY") }}</td>
                                    <!--<td class="text-center">-->
                                        <!--<span v-if="invoice.expired">-->
                                            <!--<div class="mb-2 mr-2 badge badge-dark">Expiré</div>-->
                                        <!--</span>-->
                                        <!--<span v-if="!invoice.expired">-->
                                            <!--{{ invoice.deadline.d }} jour(s) restant-->
                                        <!--</span>-->
                                    <!--</td>-->
                                    <td class="text-center">
                                        <div v-if="invoice.status !== 'draft' && invoice.state !== 'unpaid'">
                                            <div class="progress">
                                                <div class="progress-bar" role="progressbar" v-bind:aria-valuenow="invoice.amount_paid"
                                                     aria-valuemin="0" v-bind:aria-valuemax="invoice.amount"
                                                     v-bind:style="{width: progessPercent(invoice.amount_paid, invoice.amount)+'%'}"
                                                     v-bind:class="{'bg-success': invoice.state === 'paid', 'bg-danger': invoice.state === 'unpaid', 'bg-warning': invoice.state === 'waiting'}">
                                                    <span v-if="invoice.state === 'paid'" class="text-success">Payé</span>
                                                    <span v-if="invoice.state === 'waiting'" class="text-warning">En attente</span>
                                                    <span v-if="invoice.state === 'late'" class="text-alternate">En retard</span>
                                                </div>
                                            </div>
                                            <span v-if="invoice.state === 'waiting'">
                                                <small>{{ invoice.remaining_days }} jour(s) restant</small>
                                            </span>
                                            <span v-if="invoice.expired && !invoice.is_paid">
                                                <div class="mb-2 mr-2 badge badge-danger">En retard</div>
                                            </span>
                                        </div>
                                        <div class="badge badge-secondary float-center" v-if="invoice.status === 'draft'">Brouillon</div>
                                        <div class="badge badge-danger float-center" v-if="invoice.state === 'unpaid'">Impayé</div>
                                    </td>
                                    <td>
                                        <div class="rounded-circle avatar" v-tooltip="`${invoice.user.name} ${invoice.user.firstname}`">
                                            {{ invoice.user.avatar }}
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>N&deg; de Facture</th>
                                    <th>Intitulé</th>
                                    <th>Client</th>
                                    <th>Type</th>
                                    <th>Montant</th>
                                    <th>Date</th>
                                    <!--<th>Expire</th>-->
                                    <th>Statut</th>
                                    <th></th>
                                </tr>
                            </table>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end">
                                    <li class="page-item" v-bind:class="[{disabled: !pagination.prev_page_url}]">
                                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchInvoices(pagination.prev_page_url)">Précédent</a>
                                    </li>
                                    <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                                    <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                    <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                    <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                                        <a class="page-link" href="javascript:" @click="fetchInvoices(pagination.next_page_url)">Suivant</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import { Functions } from '../../scripts/functions'

    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        data(){
            return{
                tooltip: 'Test',
                invoices: [],
                pagination: {
                    current_page: 1,
                    total: 0
                },
                filter: {
                    status: 0,
                },
                title: '',
                description: '',
                keyword: '',
                spinner: false,
                api_token: '',
                selected: null

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchInvoices()
            }

        },

        methods: {
            fetchInvoices(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.keyword}&status=${this.filter.status}`
                let page_url = `/api/invoices?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.invoices = res.data

                        let meta = {
                            current_page: res.current_page,
                            total: res.total,
                            last_page: res.last_page,
                        };
                        let links = {
                            next_page_url: res.next_page_url,
                            prev_page_url: res.prev_page_url,
                        }
                        vm.makePagination(meta, links)
                    })
                    .catch(error => {
                        console.log(error)
                        this.spinner = false
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
            makePagination(meta, links){
                let pagination = {
                    current_page: meta.current_page,
                    total: meta.total,
                    last_page: meta.last_page,
                    next_page_url: links.next,
                    prev_page_url: links.prev,
                }

                this.pagination = pagination;
            },
            selectRow(id){
                this.selected = id
            },
            create(){
                window.location = '/invoice/create';
            },
            search(){
                this.fetchInvoices();
            },
            deleteCustomer(id){
                let vm = this;

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`api/customer/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                            icon: 'success',
                            title: 'Ce client a été supprimé',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                        vm.fetchCustomers();
                    }
                })

            },
            openInvoice(id){
                window.location = `/invoice/${id}/edit`;
            },
            printInvoice(id){
                window.open(`/invoice/print/${id}`, '_blank');
            },
            progessPercent(min, max){
                return Math.ceil((min * 100)/max);
            },
            convertInvoice(){

            },
            addRecurrence(){

            },
            cancelRecurrence(){

            },
            printInvoice(){

            },
            sendEmail(){

            },
            duplicateInvoice(){

            },
            deleteInvoice(){

            },
            validateInvoice(invoice){
                let temp = {...invoice}
                temp.status = 'validated'
                this.$swal({
                    title: "Validation",
                    text: "Etes-vous sur de vouloir valider cette facture?",
                    showCancelButton: true,
                    confirmButtonText: "Valider",
                    confirmButtonColor: '#28A745',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`/api/invoices/${invoice.id}?api_token=${this.api_token}`, {
                            method: 'PATCH',
                            body: JSON.stringify(temp),
                            headers: {
                                'content-type': 'application/json'
                            }
                        })
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
                        invoice = {...result.value.data};
                        let index = this.invoices.findIndex(x => x.id === invoice.id);
                        if(index !== -1)
                            this.invoices[index] = {...invoice};
                        this.$forceUpdate();
                        Functions.showAlert('top-end', 'success', "Facture validé!")
                    }
                })
            }
        }

    }
</script>
