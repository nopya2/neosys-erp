<template>
    <div class="card-block table-border-style">
        <div class="row mb-2">
            <div class="col-sm-3 offset-md-6">
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label text-right">Exercice</label>
                    <div class="col-sm-9">
                        <select class="form-control" v-model="filter.exercice" @change="search">
                            <option v-for="(year, index) in years" v-bind:value="year">{{ year }}</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <span class="badge badge-pill badge-primary">{{ pagination.total }}</span>
                        </span>
                    </div>
                    <input type="text" class="form-control" placeholder="Engagement, Fournisseur, Devis" aria-label="Recipient's username"
                           aria-describedby="basic-addon2" v-model="filter.keyword" v-on:keyup="search">
                    <div class="input-group-append">
                        <span class="input-group-text">
                            <i class="feather icon-search"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="table-border-style">
            <div class="d-flex justify-content-center mb-3" v-if="spinner">
                <div class="spinner-grow text-warning" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="example1">
                    <thead>
                    <tr style="text-align: center;">
                        <th>#</th>
                        <th>N&deg; engagement</th>
                        <th>Fournisseur</th>
                        <th>N&deg; devis</th>
                        <th>Nature de la dépense</th>
                        <th>Destination</th>
                        <th>Intitulé de la dépense</th>
                        <th>Date</th>
                        <th>Montant payé</th>
                        <th>Utilisateur</th>
                    </tr>
                    </thead>
                    <tbody style="font-size: 14px">
                    <tr>
                        <td colspan="11" v-if="echelons.length <= 0">
                            Aucun engagement trouvé
                        </td>
                    </tr>
                    <tr v-for="(echelon, index) in echelons">
                        <td>{{ echelon.id }}</td>
                        <td><a v-bind:href="'/engagements/'+echelon.engagement.id" target="_top">{{ echelon.n_engage }}</a></td>
                        <td>{{ echelon.engagement.l_nmtir }}</td>
                        <td>{{ echelon.engagement.n_devis }}</td>
                        <td>{{ echelon.engagement.nat_dep }}</td>
                        <td>{{ echelon.engagement.l_dep }}</td>
                        <td>{{ echelon.engagement.l_depeng }}</td>
                        <td>{{ echelon.date_paiement }}</td>
                        <td class="text-center">
                            <span class="badge badge-info">{{ echelon.m_paye|numFormat }}</span>
                        </td>
                        <td>{{ echelon.user.name }} {{ echelon.user.firstname }}</td>
                    </tr>
                    </tbody>
                    <tfoot>
                    <tr style="text-align: center;">
                        <th>#</th>
                        <th>N&deg; engagement</th>
                        <th>Fournisseur</th>
                        <th>N&deg; devis</th>
                        <th>Nature de la dépense</th>
                        <th>Destinataire</th>
                        <th>Intitulé de la dépense</th>
                        <th>Date</th>
                        <th>Montant payé</th>
                        <th>Utilisateur</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-end">
                    <li class="page-item" v-bind:class="[{disabled: !pagination.prev_page_url}]">
                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchEngagements(pagination.prev_page_url)">Précédent</a>
                    </li>
                    <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                    <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                    <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                    <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                        <a class="page-link" href="javascript:" @click="fetchEngagements(pagination.next_page_url)">Suivant</a>
                    </li>
                </ul>
            </nav>
        </div>

    </div>
</template>

<script>
    export default {
        mounted() {
        },

        props : [],

        data(){
            return{
                echelons: [],
                filter: {
                    keyword: '',
                    exercice: '',
                },
                spinner: false,
                api_token: '',
                pagination: {
                    current_page: 1,
                    total: 0
                },
                btnLoading: false,
                years: [],
                exercice: 0

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.loadYears()
                this.fetchEchelons()
            }

        },

        methods: {
            fetchEchelons(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.filter.keyword}&exercice=${this.filter.exercice}`
                let page_url = `/api/echelons?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.echelons = res.data
                        vm.makePagination(res.meta, res.links)
                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinner = false
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
                this.fetchEchelons();
            },
            loadYears(){
                var dt = new Date();
                let start = parseInt(dt.getFullYear())
                this.filter.exercice = parseInt(dt.getFullYear())
                this.exercice = parseInt(dt.getFullYear())
                for(var i=0; i <= parseInt(dt.getFullYear()); i++){
                    this.years[i] = start
                    start --
                    if(start < 2010) break
                }
            }
        }

    }
</script>
