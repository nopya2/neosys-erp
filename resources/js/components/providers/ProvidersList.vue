<template>
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Liste des fournisseurs</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <div class="d-flex justify-content-center mb-3" v-if="spinnerProviders">
                        <div class="spinner-grow text-warning" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div>
                    <div class="table-responsive" v-if="!spinnerProviders">
                        <table class="table m-0" id="table-providers">
                            <thead>
                            <tr>
                                <th>Nom</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="provider in providers" @click="loadProviderData(provider.name)" v-bind:class="{ 'bg-info':  provider.name == selectedProvider}">
                                <td>{{ provider.name }}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.card-body -->
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        Détails du fournisseur
                        <div class="spinner-border spinner-border-sm text-warning align-right" role="status" v-if="spinnerDetails">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <!--<div class="d-flex justify-content-center mb-3">-->
                        <!--<div class="spinner-grow text-warning" role="status">-->
                            <!--<span class="sr-only">Loading...</span>-->
                        <!--</div>-->
                    <!--</div>-->
                    <h4 v-if="selectedProvider == ''" class="text-muted text-center">Veuillez sélectionner un fournisseur pour afficher les détails</h4>
                    <div class="row" v-if="selectedProvider != ''">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12">
                                    <ul class="nav nav-tabs" id="custom-content-below-tab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" id="custom-content-below-home-tab" data-toggle="pill" href="#custom-content-below-home" role="tab" aria-controls="custom-content-below-home" aria-selected="true">Engagements ({{ paginationEngagement.total }})</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="custom-content-below-profile-tab" data-toggle="pill" href="#custom-content-below-profile" role="tab" aria-controls="custom-content-below-profile" aria-selected="false">Echelons ({{ paginationEchelon.total }})</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="custom-content-below-tabContent">
                                        <div class="tab-pane fade active show" id="custom-content-below-home" role="tabpanel" aria-labelledby="custom-content-below-home-tab">
                                            <div class="row mt-3">
                                                <div class="col-md-3 offset-md-9">
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" placeholder="Votre recherche" v-model="filter.engagement" @change="searchEngagement"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <thead>
                                                    <tr style="text-align: center;">
                                                        <th>N&deg; engagement</th>
                                                        <th>N&deg; devis</th>
                                                        <th>Intitulé de la dépense</th>
                                                        <th>Montant engagé</th>
                                                        <th>Montant payé</th>
                                                        <th>Date</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody style="font-size: 14px">
                                                    <tr>
                                                        <td colspan="5" v-if="engagements.length <= 0">
                                                            Aucun engagement trouvé
                                                        </td>
                                                    </tr>
                                                    <tr v-for="(engagement, index) in engagements" v-bind:class="{ 'bg-success':  engagement.is_paid}">
                                                        <td>{{ engagement.n_engage }}</td>
                                                        <td>{{ engagement.n_devis }}</td>
                                                        <td>{{ engagement.l_depeng }}</td>
                                                        <td class="text-center">
                                                            <span class="badge badge-warning">{{ engagement.m_engage|numFormat }}</span>
                                                        </td>
                                                        <td class="text-center">
                                                            <span class="badge badge-info">{{ engagement.m_paye|numFormat }}</span>
                                                        </td>
                                                        <td>{{ engagement.date_paiement }}</td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination justify-content-end">
                                                    <li class="page-item" v-bind:class="[{disabled: !paginationEngagement.prev_page_url}]">
                                                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchEngagements(paginationEngagement.prev_page_url)">Précédent</a>
                                                    </li>
                                                    <li class="page-item disabled"><a class="page-link" href="javascript:">{{ paginationEngagement.current_page }}</a></li>
                                                    <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                                    <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                                    <li class="page-item" v-bind:class="[{disabled: !paginationEngagement.next_page_url}]">
                                                        <a class="page-link" href="javascript:" @click="fetchEngagements(paginationEngagement.next_page_url)">Suivant</a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                        <div class="tab-pane fade" id="custom-content-below-profile" role="tabpanel" aria-labelledby="custom-content-below-profile-tab">
                                            <div class="row mt-3">
                                                <div class="col-md-3 offset-md-9">
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" placeholder="Votre recherche" v-model="filter.echelon" @change="searchEchelon"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <thead>
                                                    <tr style="text-align: center;">
                                                        <th>N&deg; engagement</th>
                                                        <th>N&deg; devis</th>
                                                        <th>Montant payé</th>
                                                        <th>Date</th>
                                                        <th>Utilisateur</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody style="font-size: 14px">
                                                    <tr>
                                                        <td colspan="5" v-if="echelons.length <= 0">
                                                            Aucun echelon trouvé
                                                        </td>
                                                    </tr>
                                                    <tr v-for="(echelon, index) in echelons">
                                                        <td>{{ echelon.engagement.n_engage }}</td>
                                                        <td>{{ echelon.engagement.n_devis }}</td>
                                                        <td class="text-center">
                                                            <span class="badge badge-info">{{ echelon.m_paye|numFormat }}</span>
                                                        </td>
                                                        <td>{{ echelon.date_paiement }}</td>
                                                        <td>{{ echelon.user.name }}</td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination justify-content-end">
                                                    <li class="page-item" v-bind:class="[{disabled: !paginationEchelon.prev_page_url}]">
                                                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchEchelons(paginationEchelon.prev_page_url)">Précédent</a>
                                                    </li>
                                                    <li class="page-item disabled"><a class="page-link" href="javascript:">{{ paginationEchelon.current_page }}</a></li>
                                                    <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                                    <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                                    <li class="page-item" v-bind:class="[{disabled: !paginationEchelon.next_page_url}]">
                                                        <a class="page-link" href="javascript:" @click="fetchEchelons(paginationEchelon.next_page_url)">Suivant</a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--<table class="table table-bordered" id="table-engagements">-->
                                <!--<thead>-->
                                <!--<tr>-->
                                    <!--<th>N° engagement</th>-->
                                    <!--<th>N° devis</th>-->
                                    <!--<th>Intitulé dépense</th>-->
                                    <!--<th>Montant</th>-->
                                    <!--<th>Date</th>-->
                                <!--</tr>-->
                                <!--</thead>-->
                                <!--<tbody>-->
                                <!--&lt;!&ndash;<tr v-for="engagement in engagements">&ndash;&gt;-->
                                    <!--&lt;!&ndash;<td>{{ engagement.n_engage }}</td>&ndash;&gt;-->
                                    <!--&lt;!&ndash;<td>{{ engagement.n_devis }}</td>&ndash;&gt;-->
                                    <!--&lt;!&ndash;<td>{{ engagement.l_depeng }}</td>&ndash;&gt;-->
                                    <!--&lt;!&ndash;<td class="text-center"><span class="badge badge-info">{{ engagement.m_paye|numFormat }}</span></td>&ndash;&gt;-->
                                    <!--&lt;!&ndash;<td>{{ engagement.date_paiement }}</td>&ndash;&gt;-->
                                <!--&lt;!&ndash;</tr>&ndash;&gt;-->
                                <!--</tbody>-->
                            <!--</table>-->
                        </div>
                    </div>
                </div>
                <!-- /.card-body -->

            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props : [],

        data(){
            return{
                providers: [],
                engagements: [],
                echelons: [],
                filter: {
                    engagement: '',
                    echelon: ''
                },
                spinner: false,
                api_token: '',
                paginationEngagement: {
                    current_page: 1,
                    total: 0
                },
                paginationEchelon: {
                    current_page: 1,
                    total: 0
                },
                selectedProvider : '',
                spinnerProviders: true,
                spinnerDetails: false,


            }
        },
        mounted() {
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchProviders()
            }

        },

        methods: {
            fetchProviders(page_url) {
                let vm = this;
                this.spinner = true;

                page_url = page_url || `/api/providers?api_token=${this.api_token}`
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinnerProviders = false
                        this.providers = res.data

                        $(function () {
                            $("#table-providers").DataTable({
                                "lengthChange": false,
                            });
                        });
                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinnerProviders = false
                    });
            },
            searchEngagement(){
                this.fetchEngagements();
            },
            searchEchelon(){
                this.fetchEchelons()
            },
            loadProviderData(provider){
                let vm = this
                this.spinnerDetails = true
                this.selectedProvider = provider
                vm.fetchEngagements()
                // vm.fetchEchelons()

            },
            fetchEngagements(page){
                this.spinnerDetails = true
                let vm = this;

                let url_parameters = `api_token=${this.api_token}&provider=${this.selectedProvider}&keyword=${this.filter.engagement}`
                let page_url = `/api/provider/engagements?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.engagements = res.data
                        vm.makePaginationEngagement(res.meta, res.links)

                        vm.fetchEchelons()
                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinnerProviders = false
                    });
            },
            fetchEchelons(page){
                let vm = this

                let url_paramters = `api_token=${this.api_token}&provider=${this.selectedProvider}&keyword=${this.filter.echelon}`
                let page_url = `/api/provider/echelons?${url_paramters}`
                if(page) page_url = `${page}&${url_paramters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.echelons = res.data
                        vm.makePaginationEchelon(res.meta, res.links)
                        this.spinnerDetails = false
                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinnerProviders = false
                    });
            },
            makePaginationEngagement(meta, links){
                let pagination = {
                    current_page: meta.current_page,
                    total: meta.total,
                    last_page: meta.last_page,
                    next_page_url: links.next,
                    prev_page_url: links.prev,
                }

                this.paginationEngagement = pagination;
            },
            makePaginationEchelon(meta, links){
                let pagination = {
                    current_page: meta.current_page,
                    total: meta.total,
                    last_page: meta.last_page,
                    next_page_url: links.next,
                    prev_page_url: links.prev,
                }

                this.paginationEchelon = pagination;
            },
        }

    }
</script>
