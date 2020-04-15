<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <button type="button" class="btn btn-success btn-sm mb-2" @click="create">
                        <i class="fa fa-plus-circle"></i> Nouvelle commande
                    </button>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label>Statut</label>
                        <select class="form-control form-control-sm" v-model="filter.status" @change="fetchPurchaseOrders()">
                            <option value="">Tout</option>
                            <option value="draft">Brouillon</option>
                            <option value="rejected">Refusé</option>
                            <option value="canceled">Annulé</option>
                            <option value="validated">Validé (en attente de facturation)</option>
                            <option value="billed">Facturé</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label>N° de commande ou Client</label>
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
                            {{ pagination.total }} Commandes
                        </div>
                        <div class="table-responsive" style="min-height: 380px;">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>N&deg; de commande</th>
                                    <th>Intitulé</th>
                                    <th>Client</th>
                                    <th>Montant</th>
                                    <th>Date</th>
                                    <th>Expire</th>
                                    <th>Utilisateur</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-if="purchase_orders.length <=0">
                                    <td colspan="8" class="text-center">Aucune commande</td>
                                </tr>
                                <tr v-for="purchase_order in purchase_orders" style="font-size: 13px" v-bind:class="{'bg-info': selected == purchase_order.id }" @click="selectRow(purchase_order.id)">
                                    <td>
                                        <div class="dropdown d-inline-block">
                                            <button type="button" aria-haspopup="true" aria-expanded="false" data-toggle="dropdown" class="mb-2 mr-2 dropdown-toggle btn btn-primary btn-sm">{{ purchase_order.id }}</button>
                                            <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 33px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                <button type="button" tabindex="0" class="dropdown-item" @click="openPurchaseOrder(purchase_order.id,'show')"
                                                    v-if="purchase_order.status !== 'draft'">
                                                    <i class="fa fa-eye"></i>&nbsp;Détails
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item" @click="openPurchaseOrder(purchase_order.id,'edit')"
                                                        v-if="purchase_order.status === 'draft'">
                                                    <i class="fa fa-edit"></i>&nbsp;Editer
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item text-success" @click="changeStatus(purchase_order,'validate')"
                                                    v-if="purchase_order.status === 'draft'">
                                                    <i class="fa fa-check"></i>&nbsp;Valider
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item text-danger" v-if="purchase_order.status === 'draft'" @click="changeStatus(purchase_order,'reject')">
                                                    <i class="fa fa-ban"></i>&nbsp;Refuser
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item text-danger" v-if="purchase_order.status === 'validated'" @click="changeStatus(purchase_order,'cancel')">
                                                    <i class="fa fa-ban"></i>&nbsp;Annuler
                                                </button>
                                                <button type="button" tabindex="0" class="dropdown-item" v-if="purchase_order.status === 'validated'" @click="changeStatus(purchase_order,'bill')">
                                                    <i class="fa fa-file"></i>&nbsp;Facturer
                                                </button>
                                                <div class="dropdown-divider"></div>
                                                <button type="button" tabindex="0" class="dropdown-item" @click="printPurchaseOrder(purchase_order.id)">
                                                    <i class="fa fa-print"></i>&nbsp;Imprimer
                                                </button>
                                                <div class="dropdown-divider"></div>
                                                <button type="button" class="dropdown-item" @click="duplicate(purchase_order.id)">
                                                    <i class="fa fa-clone"></i>&nbsp;Dupliquer
                                                </button>
                                                <button type="button" class="dropdown-item text-danger" :disabled="purchase_order.status !== 'draft'" @click="deletePurchaseOrder(purchase_order.id)">
                                                    <i class="fa fa-trash"></i>&nbsp;Supprimer
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                    <td>{{ purchase_order.purchase_order_number }}</td>
                                    <td>{{ purchase_order.title }}</td>
                                    <td>{{ purchase_order.customer.company_name }}<br>
                                        <i class="fa fa-phone"></i> {{ purchase_order.customer.phonenumber }}
                                    </td>
                                    <td class="text-center">
                                        <div class="mb-2 mr-2 badge badge-info">{{ purchase_order.amount|numFormat }}</div>
                                    </td>
                                    <td class="text-center">{{ purchase_order.created_at| moment("DD/MM/YYYY") }}</td>
                                    <td class="text-center">
                                        <span v-if="purchase_order.status === 'draft'">
                                            <div class="mb-2 mr-2 badge badge-dark">Brouillon</div>
                                        </span>
                                        <span v-if="purchase_order.status === 'canceled'">
                                            <div class="mb-2 mr-2 badge badge-danger">Annulé</div>
                                        </span>
                                        <span v-if="purchase_order.status === 'rejected'">
                                            <div class="mb-2 mr-2 badge badge-danger">Refusé</div>
                                        </span>
                                        <span v-if="purchase_order.status === 'billed'">
                                            <div class="mb-2 mr-2 badge badge-success">Facturé</div>
                                        </span>
                                        <span v-if="purchase_order.status === 'validated'">
                                            <!--{{ purchase_order.deadline.d }} jour(s) restant-->
                                            <div class="mb-2 mr-2 badge badge-success">Validé (en attente de facturation)</div>
                                        </span>
                                    </td>
                                    <td>{{ purchase_order.user.name }}</td>
                                </tr>
                                </tbody>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>N&deg; de commande</th>
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
                                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchPurchaseOrders(pagination.prev_page_url)">Précédent</a>
                                    </li>
                                    <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                                    <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                    <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                    <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                                        <a class="page-link" href="javascript:" @click="fetchPurchaseOrders(pagination.next_page_url)">Suivant</a>
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
                purchase_orders: [],
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

                this.fetchPurchaseOrders()
            }

        },

        methods: {
            fetchPurchaseOrders(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.keyword}&status=${this.filter.status}`
                let page_url = `/api/purchase-orders?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.purchase_orders = res.data

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
                window.location = '/purchase-order/create';
            },
            search(){
                this.fetchPurchaseOrders();
            },
            deletePurchaseOrder(id){
                let vm = this;

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer cette commande?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`/api/purchase-orders/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                        Functions.showAlert('top-end', 'warning', 'Cette commande a été supprimée!');
                        vm.fetchPurchaseOrders();
                    }
                })

            },
            openPurchaseOrder(id, action){
                window.location = `/purchase-orders/${id}/edit?action=${action}`;
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
                        window.location = `/purchase-order/bill/${id}`;
                    }
                })
            },
            duplicate(id){
                this.$swal({
                    title: 'Dupliquer',
                    text: 'Etes-vous sur de vouloir dupliquer cette commande?',
                    showCancelButton: true,
                    confirmButtonText: 'Dupliquer',
                    confirmButtonColor: '#28A745',
                    // showLoaderOnConfirm: true,
                }).then((result) => {
                    if (result.value) {
                        window.location = `/purchase-orders/${id}/duplicate`;
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
                        window.open(`/purchase-order/print/${id}`, '_blank');
                    }
                })
            },
            changeStatus(purchaseOrder, action){
                let title = '';
                let text = '';
                let button  = '';
                let temp = {...purchaseOrder};
                let message = '';
                switch (action){
                    case 'validate':
                        title = 'Validation';
                        text = 'Etes-vous sur de vouloir valider cette commande?';
                        button = 'Valider';
                        temp.status = 'validated';
                        message = 'Commande validée!';
                        break;
                    case 'reject':
                        title = 'Refus';
                        text = 'Etes-vous sur de vouloir refuser cette commande?';
                        button = 'Refuser';
                        temp.status = 'rejected';
                        message = 'Commande refusée!';
                        break;
                    case 'cancel':
                        title = 'Annulation';
                        text = 'Etes-vous sur de vouloir annuler cette commande?';
                        button = 'Annuler';
                        temp.status = 'canceled';
                        message = 'Commande annulée!';
                        break;
                    case 'bill':
                        title = 'Facturation';
                        text = 'Etes-vous sur de vouloir facturer cette commande?';
                        button = 'Facturer';
                        message = 'Commande facturée!';
                        temp.status = 'billed';
                        break;
                }

                this.$swal({
                    title: title,
                    text: text,
                    showCancelButton: true,
                    confirmButtonText: button,
                    confirmButtonColor: '#28A745',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`/api/purchase-orders/${purchaseOrder.id}?api_token=${this.api_token}`, {
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
                        // window.open(`/purchase-order/print/${id}`, '_blank');
                        purchaseOrder = {...result.value.data};
                        let index = this.purchase_orders.findIndex(x => x.id === purchaseOrder.id);
                        if(index !== -1)
                            this.purchase_orders[index] = {...purchaseOrder};
                        this.$forceUpdate();
                        Functions.showAlert('top-end', 'warning', message)
                    }
                })
            },

        }

    }
</script>
