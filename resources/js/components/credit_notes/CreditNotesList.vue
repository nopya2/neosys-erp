<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-3 offset-md-6">
                    <label>Type d'avoir</label>
                    <select class="form-control form-control-sm" v-model="filter.type" @change="search">
                        <option value="">Tout</option>
                        <option value="1">Avoir commercial</option>
                        <option value="2">Retour marchandise ou annulation prestation</option>
                        <option value="3">Erreur de facturation</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label>N° d'avoir, N° de facture, Client</label>
                        <input type="text" class="form-control form-control-sm" placeholder="Tapez votre recherche" aria-label="Recipient's customername"
                               aria-describedby="basic-addon2" v-model="keyword" v-on:keyup="search">
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
                            {{ pagination.total }} Devis
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>N&deg; d'avoir</th>
                                    <th>Référence facture</th>
                                    <th>Type</th>
                                    <th>Client</th>
                                    <th>Remise</th>
                                    <th>Montant</th>
                                    <th>Date</th>
                                    <th>Utilisateur</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-if="invoices.length <= 0">
                                    <td colspan="9" class="text-center">
                                        Aucun avoir
                                    </td>
                                </tr>
                                <tr v-for="invoice in invoices" style="font-size: 13px">
                                    <td>
                                        <div class="dropdown d-inline-block">
                                            <button type="button" aria-haspopup="true" aria-expanded="false" data-toggle="dropdown" class="mb-2 mr-2 dropdown-toggle btn btn-primary">{{ invoice.id }}</button>
                                            <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 33px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                <button type="button" tabindex="0" class="dropdown-item" @click="printInvoice(invoice.id)">
                                                    <i class="fa fa-print"></i>&nbsp;Imprimer
                                                </button>
                                                <button type="button" class="dropdown-item" @click="sendEmail(invoice)">
                                                    <i class="fa fa-envelope"></i>&nbsp;Envoyer
                                                </button>
                                                <div class="dropdown-divider"></div>
                                                <button type="button" class="dropdown-item" @click="deleteInvoice(invoice.id)">
                                                    <i class="fa fa-trash"></i>&nbsp;Supprimer
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                    <td>{{ invoice.credit_note_number }}</td>
                                    <td>{{ invoice.invoice.invoice_number }}</td>
                                    <td>{{ invoice.text_type }}</td>
                                    <td>
                                        {{ invoice.customer.company_name }}<br>
                                        <i class="fa fa-phone"></i> {{ invoice.customer.phonenumber }}
                                    </td>
                                    <td class="text-center">
                                        <div class="mb-2 mr-2 badge badge-info" v-if="invoice.percent_discount > 0">{{ invoice.percent_discount }}%</div>
                                        <div class="mb-2 mr-2 badge badge-primary" v-if="invoice.amount_discount > 0">{{ invoice.amount_discount|numFormat }}</div>
                                    </td>
                                    <td class="text-center">
                                        <div class="mb-2 mr-2 badge badge-warning">{{ invoice.amount|numFormat }}</div>
                                    </td>
                                    <td class="text-center">{{ invoice.updated_at| moment("DD/MM/YYYY") }}</td>
                                    <td>{{ invoice.user.name }}</td>
                                </tr>
                                </tbody>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>N&deg; d'avoir</th>
                                    <th>Reference facture</th>
                                    <th>Type</th>
                                    <th>Client</th>
                                    <th>Remise</th>
                                    <th>Montant</th>
                                    <th>Date</th>
                                    <th>Utilisateur</th>
                                </tr>
                            </table>
                        </div>

                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-end">
                                <li class="page-item" v-bind:class="[{disabled: !pagination.prev_page_url}]">
                                    <a class="page-link" href="javascript:" tabindex="-1" @click="fetchQuotes(pagination.prev_page_url)">Précédent</a>
                                </li>
                                <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                                <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                                    <a class="page-link" href="javascript:" @click="fetchQuotes(pagination.next_page_url)">Suivant</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        data(){
            return{
                invoices: [],
                pagination: {
                    current_page: 1,
                    total: 0
                },
                filter: {
                    type: ''
                },
                title: '',
                description: '',
                keyword: '',
                spinner: false,
                api_token: ''

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

                let url_parameters = `api_token=${this.api_token}&keyword=${this.keyword}&type=${this.filter.type}`
                let page_url = `/api/credit-notes?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.invoices = res.data
                        vm.makePagination(res.meta, res.links)
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
            search(){
                this.fetchInvoices();
            },
            deleteInvoice(id){

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`api/credit-note/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                            title: 'Cet avoir a été supprimé',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                        this.fetchInvoices();
                    }
                })

            },
            printInvoice(id){
                window.open(`/credit-note/print/${id}`, '_blank');
            },
            sendEmail(invoice){
                this.spinner = true
                fetch(`/api/credit-note/send-email?api_token=${this.api_token}`, {
                    method: 'POST',
                    body: JSON.stringify(invoice),
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

        }

    }
</script>
