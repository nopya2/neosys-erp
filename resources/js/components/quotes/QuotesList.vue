<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <button type="button" class="btn btn-success btn-sm mb-2" @click="create">
                        <i class="fa fa-plus-circle"></i> Nouveau devis
                    </button>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label>Statut</label>
                        <select class="form-control form-control-sm" v-model="filter.status" @change="fetchQuotes()">
                            <option value="">Tout</option>
                            <option value="canceled">Expiré</option>
                            <option value="in_progress">En cours</option>
                            <option value="purchased">Commandé</option>
                            <option value="billed">Facturé</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label>N° de devis ou Client</label>
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
                            {{ pagination.total }} Devis
                        </div>
                        <div class="table-responsive" style="min-height: 380px;">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>N&deg; de devis</th>
                                    <th>Intitulé</th>
                                    <th>Client</th>
                                    <th>Montant</th>
                                    <th>Date</th>
                                    <th>Expire</th>
                                    <th>Utilisateur</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-if="quotes.length <=0">
                                    <td colspan="8" class="text-center">Aucun devis</td>
                                </tr>
                                <tr v-for="quote in quotes" style="font-size: 13px" v-bind:class="{'bg-info': selected == quote.id }" @click="selectRow(quote.id)">
                                    <td>
                                        <div class="dropdown d-inline-block">
                                            <button type="button" aria-haspopup="true" aria-expanded="false" data-toggle="dropdown" class="mb-2 mr-2 dropdown-toggle btn btn-primary btn-sm">{{ quote.id }}</button>
                                            <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 33px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                <button type="button" tabindex="0" class="dropdown-item" @click="openQuote(quote.id,'show')" v-if="quote.status === 'billed'">
                                                    <i class="fa fa-eye"></i>&nbsp;Détails
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item" @click="openQuote(quote.id,'edit')" v-if="quote.status !== 'canceled' && quote.status !== 'billed'">
                                                    <i class="fa fa-edit"></i>&nbsp;Editer
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item" @click="openQuote(quote.id,'reedit')" v-if="quote.status === 'canceled' && quote.status !== 'billed'">
                                                    <i class="fa fa-edit"></i>&nbsp;Rééditer
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item" :disabled="quote.status === 'billed' || quote.status === 'canceled'" @click="billQuote(quote.id)">
                                                    <i class="fa fa-file"></i>&nbsp;Facturer
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item" @click="printQuote(quote.id)">
                                                    <i class="fa fa-print"></i>&nbsp;Imprimer
                                                </button>
                                                <div class="dropdown-divider"></div>
                                                <button type="button" tabindex="0" class="dropdown-item" @click="printPurchaseOrder(quote.id)" :disabled="quote.status === 'purchased' || quote.status === 'canceled'">
                                                    <i class="fa fa-print"></i>&nbsp;Générer bon de commande
                                                </button>
                                                <div class="dropdown-divider"></div>
                                                <button type="button" class="dropdown-item" @click="duplicateQuote(quote.id)">
                                                    <i class="fa fa-clone"></i>&nbsp;Dupliquer
                                                </button>
                                                <button type="button" class="dropdown-item text-danger" :disabled="quote.status === 'billed'" @click="deleteQuote(quote.id)">
                                                    <i class="fa fa-trash"></i>&nbsp;Supprimer
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                    <td>{{ quote.quote_number }}</td>
                                    <td>{{ quote.title }}</td>
                                    <td>{{ quote.customer.company_name }}<br>
                                        <i class="fa fa-phone"></i> {{ quote.customer.phonenumber }}
                                    </td>
                                    <td class="text-center">
                                        <div class="mb-2 mr-2 badge badge-info">{{ quote.amount|numFormat }}</div>
                                    </td>
                                    <td class="text-center">{{ quote.updated_at| moment("DD/MM/YYYY") }}</td>
                                    <td class="text-center">
                                        <span v-if="quote.status === 'canceled'">
                                            <div class="mb-2 mr-2 badge badge-dark">Expiré</div>
                                        </span>
                                        <span v-if="quote.status === 'billed'">
                                            <div class="mb-2 mr-2 badge badge-success">Facturé</div>
                                        </span>
                                        <span v-if="quote.status === 'purchased'">
                                            <div class="mb-2 mr-2 badge badge-success">Commandé</div>
                                        </span>
                                        <span v-if="quote.status === 'in_progress'">
                                            {{ quote.deadline.d }} jour(s) restant
                                        </span>
                                    </td>
                                    <td>{{ quote.user.name }}</td>
                                </tr>
                                </tbody>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>N&deg; de devis</th>
                                    <th>Intitulé</th>
                                    <th>Client</th>
                                    <th>Montant</th>
                                    <th>Date</th>
                                    <th>Expire</th>
                                    <th>Utilisateur</th>
                                </tr>
                            </table>
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
                quotes: [],
                pagination: {
                    current_page: 1,
                    total: 0
                },
                filter: {
                    status: ''
                },
                title: '',
                description: '',
                keyword: '',
                spinner: false,
                api_token: '',
                selected: 0,

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchQuotes()
            }

        },

        methods: {
            fetchQuotes(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.keyword}&status=${this.filter.status}`
                let page_url = `/api/quotes?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.quotes = res.data

                        let meta = {
                            current_page: res.current_page,
                            total: res.total,
                            last_page: res.last_page_url,
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
                        Functions.showAlert('top-end', 'error', 'Erreur chargement des données!')
                    });
            },
            makePagination(meta, links){
                let pagination = {
                    current_page: meta.current_page,
                    last_page: meta.last_page,
                    next_page_url: links.next_page_url,
                    prev_page_url: links.prev_page_url,
                    total: meta.total
                }

                this.pagination = pagination;
            },
            selectRow(id){
                this.selected = id
            },
            create(){
                window.location = '/quote/create';
            },
            search(){
                this.fetchQuotes();
            },
            deleteQuote(id){
                let vm = this;

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`api/quote/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                        Functions.showAlert('top-end', 'warning', 'Ce devis a été supprimé!');
                        vm.fetchQuotes();
                    }
                })

            },
            openQuote(id, action){
                window.location = `/quote/${id}/edit?action=${action}`;
            },
            printQuote(id){
                window.open(`/quote/print/${id}`, '_blank');
            },
            billQuote(id){
                this.$swal({
                    title: 'Facturer',
                    text: 'Etes-vous sur de vouloir facturer ce devis?',
                    showCancelButton: true,
                    confirmButtonText: 'Facturer',
                    confirmButtonColor: '#28A745',
                    // showLoaderOnConfirm: true,
                }).then((result) => {
                    if (result.value) {
                        window.location = `/quote/bill/${id}`;
                    }
                })
            },
            duplicateQuote(id){
                this.$swal({
                    title: 'Dupliquer',
                    text: 'Etes-vous sur de vouloir dupliquer ce devis?',
                    showCancelButton: true,
                    confirmButtonText: 'Dupliquer',
                    confirmButtonColor: '#28A745',
                    // showLoaderOnConfirm: true,
                }).then((result) => {
                    if (result.value) {
                        window.location = `/quote/duplicate/${id}`;
                    }
                })
            },
            printPurchaseOrder(id){
                this.$swal({
                    title: 'Bon de commande',
                    text: 'Etes-vous sur de vouloir générer le bon de commande?',
                    showCancelButton: true,
                    confirmButtonText: 'Générer',
                    confirmButtonColor: '#28A745',
                    // showLoaderOnConfirm: true,
                }).then((result) => {
                    if (result.value) {
                        window.open(`/quote/purchase-order/print/${id}`, '_blank');
                    }
                })
            }

        }

    }
</script>
