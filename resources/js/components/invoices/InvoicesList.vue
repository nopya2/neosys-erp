<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-3">
                    <button type="button" class="btn btn-success btn-sm" @click="create">
                        <i class="fa fa-plus-circle"></i> Nouvelle facture
                    </button>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <select class="form-control form-control-sm" v-model="filter.type" @change="search">
                            <option value="">Tous les type</option>
                            <option value="standard">Facture standard</option>
                            <option value="credit_note">Avoir</option>
                            <option value="deposit">Accompte</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <select class="form-control form-control-sm" v-model="filter.status" @change="search">
                            <option value="">Tous les états</option>
                            <option value="draft">Brouillon</option>
                            <option value="late">En retard</option>
                            <option value="waiting">En cours</option>
                            <option value="paid">Payé</option>
                            <option value="unpaid">Impayé</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <input type="text" class="form-control form-control-sm" placeholder="Recherche" v-model="filter.keyword" v-on:input="search">
                    </div>
                </div>
            </div>
            <div class="form-inline">
                <div class="mb-2 mr-sm-2 mb-sm-0 position-relative form-group">
                    <select class="form-control form-control-sm" v-model="filter.period" @change="initDates">
                        <option value="">Toutes les dates</option>
                        <option value="last_twelve_months">12 derniers mois</option>
                        <option value="last_six_months">6 derniers mois</option>
                        <option value="last_three_months">3 derniers</option>
                        <option value="current_month">Mois en cours</option>
                        <option value="last_month">Mois dernier</option>
                        <option value="custom_dates">Dates personnalisées</option>
                    </select>
                </div>
                <div class="mb-2 mr-sm-2 mb-sm-0 position-relative form-group" v-if="filter.period === 'custom_dates'">
                    <label class="mr-sm-2">Du</label>
                    <!--<input name="start"  type="text" class="form-control form-control-sm" v-model="filter.start">-->
                    <datepicker :input-class="'form-control form-control-sm'" v-model="datepicker.start" :format="'dd/MM/yyyy'"
                        :language="fr" @input="setCustomDates()"></datepicker>
                </div>
                <div class="mb-2 mr-sm-2 mb-sm-0 position-relative form-group" v-if="filter.period === 'custom_dates'">
                    <label class="mr-sm-2">Au</label>
                    <!--<input name="end"  type="text" class="form-control form-control-sm" v-model="filter.end">-->
                    <datepicker :input-class="'form-control form-control-sm'" v-model="datepicker.end" :format="'dd/MM/yyyy'"
                        :language="fr" @input="setCustomDates()"></datepicker>
                </div>
                <button class="btn btn-sm border-0 btn-outline-danger btn-transition" @click="resetFilter" v-tooltip="`Réinitialiser filtre`">
                    <i class="fas fa-redo"></i>
                </button>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="table-border-style mt-2">
                        <div class="d-flex justify-content-center mb-3" v-if="spinner">
                            <div class="spinner-grow text-warning" role="status">
                                <span class="sr-only">Loading...</span>
                            </div>
                        </div>
                        <div>
                            {{ pagination.total }} Facture(s)
                        </div>
                        <div class="table-responsive" style="min-height: 450px;">
                            <table class="table table-cursor">
                                <thead>
                                <tr style="text-align: center;">
                                    <th @click="changeSort('id')">
                                        #
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'id'"></filter-list>
                                    </th>
                                    <th @click="changeSort('invoice_number')">
                                        N&deg; de facture
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'invoice_number'"></filter-list>
                                    </th>
                                    <th @click="changeSort('title')">
                                        Intitulé
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'title'"></filter-list>
                                    </th>
                                    <th>
                                        Client
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'company_name'"></filter-list>
                                    </th>
                                    <th @click="changeSort('title')">
                                        Type
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'type'"></filter-list>
                                    </th>
                                    <th @click="changeSort('amount')">
                                        Montant
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'amount'"></filter-list>
                                    </th>
                                    <th @click="changeSort('updated_at')">
                                        Date
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'updated_at'"></filter-list>
                                    </th>
                                    <!--<th>Expire</th>-->
                                    <th>Statut</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-if="invoices.length <= 0">
                                    <td colspan="9" class="text-center">Aucune facture</td>
                                </tr>
                                <tr v-for="invoice in invoices" style="font-size: 13px" v-bind:class="{'bg-selected': selected == invoice.id }" @click="selected = invoice.id">
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
                                                <button type="button" class="dropdown-item" @click="convertInvoice(invoice)" :disabled="invoice.status === 'draft'" v-if="invoice.type ==='standard'">
                                                    <i class="fa fa-file"></i>&nbsp;Convertir en facture d'avoir
                                                </button>
                                                <button type="button" class="dropdown-item" :disabled="invoice.status === 'draft'" @click="addRecurrence" v-if="!invoice.recurrence && invoice.type ==='standard'">
                                                    <i class="fa fa-clock"></i>&nbsp;Récurrence
                                                </button>
                                                <button type="button" class="dropdown-item" @click="cancelRecurrence" v-if="invoice.recurrence">
                                                    <i class="fa fa-clock"></i>&nbsp;Annuler la Récurrence
                                                </button>
                                                <button type="button" class="dropdown-item" :disabled="invoice.status == 0" @click="printInvoice(invoice.id)">
                                                    <i class="fa fa-print"></i>&nbsp;Imprimer
                                                </button>
                                                <button type="button" class="dropdown-item" :disabled="invoice.status == 0" @click="sendEmail()">
                                                    <i class="fa fa-envelope"></i>&nbsp;Envoyer par mail
                                                </button>
                                                <div class="dropdown-divider"></div>
                                                <button type="button" class="dropdown-item" @click="duplicateInvoice(invoice)" :disabled="invoice.type != 'standard'">
                                                    <i class="fa fa-clone"></i>&nbsp;Dupliquer
                                                </button>
                                                <button type="button" class="dropdown-item" :disabled="invoice.status != 'draft'" @click="deleteInvoice(invoice)">
                                                    <span class="text-danger"><i class="fa fa-trash"></i>&nbsp;Supprimer</span>
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                    <td>{{ invoice.invoice_number }}</td>
                                    <td>{{ invoice.title }}</td>
                                    <td width="250">
                                        <span v-tooltip="`${invoice.customer.phonenumber}`">
                                            {{ invoice.customer.company_name }}
                                        </span>
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
                                                     v-bind:class="{'bg-success': invoice.state === 'paid', 'bg-danger': invoice.state === 'unpaid', 'bg-warning': invoice.state === 'waiting', 'bg-alternate': invoice.state === 'late'}">
                                                    <span v-if="invoice.state === 'paid'">Payé</span>
                                                    <span v-if="invoice.state === 'waiting'">En attente</span>
                                                    <span v-if="invoice.state === 'late'">En retard</span>
                                                </div>
                                            </div>
                                            <span v-if="invoice.state === 'waiting'">
                                                <small>{{ invoice.remaining_days }} jour(s)</small>
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
                                <tfoot>
                                <tr style="text-align: center;">
                                    <th @click="changeSort('id')">
                                        #
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'id'"></filter-list>
                                    </th>
                                    <th @click="changeSort('invoice_number')">
                                        N&deg; de facture
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'invoice_number'"></filter-list>
                                    </th>
                                    <th @click="changeSort('title')">
                                        Intitulé
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'title'"></filter-list>
                                    </th>
                                    <th>
                                        Client
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'company_name'"></filter-list>
                                    </th>
                                    <th @click="changeSort('title')">
                                        Type
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'type'"></filter-list>
                                    </th>
                                    <th @click="changeSort('amount')">
                                        Montant
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'amount'"></filter-list>
                                    </th>
                                    <th @click="changeSort('updated_at')">
                                        Date
                                        <filter-list :order="filter.order" :sort="filter.sort" :name="'updated_at'"></filter-list>
                                    </th>
                                    <!--<th>Expire</th>-->
                                    <th>Statut</th>
                                    <th></th>
                                </tr>
                                </tfoot>
                            </table>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end">
                                    <li class="page-item" v-bind:class="[{disabled: pagination.current_page == 1}]">
                                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchInvoices(pagination.first_page_url)">Début</a>
                                    </li>
                                    <li class="page-item" v-bind:class="[{disabled: !pagination.prev_page_url}]">
                                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchInvoices(pagination.prev_page_url)">Précédent</a>
                                    </li>
                                    <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                                    <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                    <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                    <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                                        <a class="page-link" href="javascript:" @click="fetchInvoices(pagination.next_page_url)">Suivant</a>
                                    </li>
                                    <li class="page-item" v-bind:class="[{disabled: pagination.current_page == pagination.last_page}]">
                                        <a class="page-link" href="javascript:" @click="fetchInvoices(pagination.last_page_url)">Fin</a>
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
    import Datepicker from 'vuejs-datepicker';
    import {en, es, fr} from 'vuejs-datepicker/dist/locale'

    export default {
        mounted() {
            // console.log('Component mounted.')
        },
        components: {
            Datepicker
        },
        data(){
            return{
                fr: fr,
                tooltip: 'Test',
                invoices: [],
                pagination: {
                    current_page: 1,
                    total: 0
                },
                filter: {
                    status: '',
                    order: 'desc',
                    sort: 'id',
                    period: '',
                    start: '1900-01-01',
                    end: this.$moment().format('YYYY-MM-DD'),
                    type: '',
                    keyword: ''
                },
                title: '',
                description: '',
                spinner: false,
                api_token: '',
                selected: null,
                datepicker: {
                    start: new Date(),
                    end: new Date()
                }

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.initDates()
                // this.fetchInvoices()
            }

        },

        methods: {
            fetchInvoices(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.filter.keyword}&status=${this.filter.status}`
                                    +`&order=${this.filter.order}&sort=${this.filter.sort}&start=${this.filter.start}`
                                    +`&end=${this.filter.end}&type=${this.filter.type}`
                let page_url = `/api/invoices?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.invoices = res.data

                        let meta = {
                            current_page: res.current_page,
                            last_page: res.last_page,
                            total: res.total,
                        };
                        let links = {
                            next_page_url: res.next_page_url,
                            prev_page_url: res.prev_page_url,
                            last_page_url: res.last_page_url,
                            first_page_url: res.first_page_url,
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
                    last_page: meta.last_page,
                    next_page_url: links.next_page_url,
                    prev_page_url: links.prev_page_url,
                    last_page_url: links.last_page_url,
                    first_page_url: links.first_page_url,
                    total: meta.total
                }

                this.pagination = pagination;
            },
            changeSort(sort){
                this.filter.sort = sort
                if(this.filter.order === 'desc')
                    this.filter.order = 'asc'
                else
                    this.filter.order = 'desc'

                this.fetchInvoices()
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
            resetFilter(){
                this.filter = {
                    status: '',
                    order: 'desc',
                    sort: 'id',
                    period: '',
                    start: '1900-01-01',
                    end: this.$moment().format('YYYY-MM-DD'),
                    type: '',
                    keyword: ''
                }
                this.search()

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
            convertInvoice(invoice){
                let temp = {...invoice}
                temp.type = 'credit_note'
                this.$swal({
                    title: "Avoir",
                    text: "Etes-vous sur de vouloir convertir cette facture?",
                    showCancelButton: true,
                    confirmButtonText: "Convertir",
                    confirmButtonColor: '#28A745',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`/api/invoice?api_token=${this.api_token}&action=convert`, {
                            method: 'POST',
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
                        Functions.showAlert('top-end', 'success', 'Facture convertie en avoir!')
                        window.location = `/invoice/${result.value.data.id}/edit`
                    }
                })

            },
            addRecurrence(){

            },
            cancelRecurrence(){

            },
            printInvoice(){

            },
            sendEmail(invoice){
                this.$swal({
                    title: "Envoyer mail",
                    text: "Etes-vous sur de vouloir envoyer cette facture?",
                    showCancelButton: true,
                    confirmButtonText: "Envoyer",
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
                        Functions.showAlert('top-end', 'success', "E-mail envoyé!")
                    }
                })
            },
            duplicateInvoice(invoice){
                this.$swal({
                    title: 'Dupliquer',
                    text: 'Etes-vous sur de vouloir dupliquer cette facture?',
                    showCancelButton: true,
                    confirmButtonText: 'Dupliquer',
                    confirmButtonColor: '#28A745',
                    // showLoaderOnConfirm: true,
                }).then((result) => {
                    if (result.value) {
                        window.location = `/invoice/create?action=duplicate&i=${invoice.id}`;
                    }
                })
            },
            deleteInvoice(invoice){

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer cette facture?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`/api/invoice/${invoice.id}?api_token=${this.api_token}`, { method: 'delete' })
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
                        Functions.showAlert('top-end', 'warning', 'Cette facture a été supprimée')
                        this.fetchInvoices()
                    }
                })
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
            },
            initDates(){
                let $now = new Date();
                this.filter.start = this.$moment('1900-01-01').format('YYYY-MM-DD')
                this.filter.end = this.$moment().format('YYYY-MM-DD')

                switch (this.filter.period){
                    case 'last_twelve_months':
                        this.filter.start = this.$moment().subtract(1, 'years').format('YYYY-MM-DD');
                        this.filter.end = this.$moment().format('YYYY-MM-DD');
                        this.search()
                        break
                    case 'last_six_months':
                        this.filter.start = this.$moment().subtract(6, 'months').format('YYYY-MM-DD');
                        this.filter.end = this.$moment().format('YYYY-MM-DD');
                        this.search()
                        break
                    case 'last_three_months':
                        this.filter.start = this.$moment().subtract(3, 'months').format('YYYY-MM-DD');
                        this.filter.end = this.$moment().format('YYYY-MM-DD');
                        this.search()
                        break
                    case 'current_month':
                        this.filter.start = this.$moment().startOf('month').format('YYYY-MM-DD');
                        this.filter.end = this.$moment().endOf('month').format('YYYY-MM-DD');
                        this.search()
                        break
                    case 'last_month':
                        this.filter.start = this.$moment().subtract(1, 'months').startOf('month').format('YYYY-MM-DD');
                        this.filter.end = this.$moment().subtract(1, 'months').endOf('month').format('YYYY-MM-DD');
                        this.search()
                        break
                    case 'custom_dates':
                        this.datepicker.start = new Date()
                        this.datepicker.end = new Date()
                        this.setCustomDates()
                        break
                    default:
                        this.search()
                        break
                }
            },
            setCustomDates(){
                this.filter.start = this.$moment(this.datepicker.start).format('YYYY-MM-DD')
                this.filter.end = this.$moment(this.datepicker.end).format('YYYY-MM-DD')
                this.search()
            }
        }

    }
</script>
