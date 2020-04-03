<template>
    <div class="card-block table-border-style">
        <div class="row mb-2">
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Debut</label>
                            <select v-model="filter.year.start" class="form-control form-control-sm" @change="selectStart">
                                <option v-for="(year, index) in years" v-bind:value="year">{{ year }}</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Fin</label>
                            <select v-model="filter.year.end" class="form-control form-control-sm" @change="selectEnd">
                                <option v-for="(year, index) in years" v-bind:value="year">{{ year }}</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Fournisseur</label>
                    <select v-model="filter.provider" class="form-control form-control-sm">
                        <option value="">Tout</option>
                        <option v-for="(provider, index) in providers" v-bind:value="provider.name">{{ provider.name }}</option>
                    </select>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Statut</label>
                    <select v-model="filter.status" class="form-control form-control-sm">
                        <option value="">Tout</option>
                        <option value="paye">Payé</option>
                        <option value="non_paye">Non Payé</option>
                    </select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label>N° facture ou devis</label>
                    <input type="text" class="form-control form-control-sm" v-model="filter.devis" placeholder="N° facture ou devis"/>
                </div>
            </div>
            <div class="col-md-1">
                <div class="form-group text-center">
                    <button class="btn btn-info mt-4" @click="search">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="table-border-style">
            <div class="row">
                <div class="col-md-12">
                    <div class="d-flex justify-content-center mb-3" v-if="spinner">
                        <div class="spinner-grow text-warning" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    {{ pagination.total }} engagement(s)
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="example1">
                    <thead>
                    <tr style="text-align: center;">
                        <th>#</th>
                        <th>d_exerci</th>
                        <th>c_dest</th>
                        <th>nat_dep</th>
                        <th>l_dep</th>
                        <th>m_dispo</th>
                        <th>m_toteng</th>
                        <th>m_tengvi</th>
                        <th>m_totliq</th>
                        <th>m_tordvi</th>
                        <th>m_totord</th>
                        <th>m_dotini</th>
                        <th>n_engage</th>
                        <th>m_engage</th>
                        <th>date_depot_ac</th>
                        <th>date_paiement</th>
                        <th>m_paye</th>
                        <th>d_engage</th>
                        <th>mois_</th>
                        <th>m_tliqenga</th>
                        <th>m_non_paye</th>
                        <th>l_depeng</th>
                        <th>l_nmtir</th>
                        <th>n_mattir</th>
                        <th>c_mattir</th>
                        <th>l_chap</th>
                        <th>n_devis</th>
                        <th>nip</th>
                    </tr>
                    </thead>
                    <tbody style="font-size: 14px">
                    <tr>
                        <td colspan="28" v-if="engagements.length <= 0">
                            Aucun engagement trouvé
                        </td>
                    </tr>
                    <tr v-for="(engagement, index) in engagements" v-bind:key="engagement.id">
                        <td>
                            <a v-bind:href="'/engagements/'+engagement.id">
                                <button class="btn btn-sm btn-info" title="Visualiser">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </a>
                        </td>
                        <td>{{ engagement.d_exerci }}</td>
                        <td>{{ engagement.c_dest }}</td>
                        <td>{{ engagement.nat_dep }}</td>
                        <td>{{ engagement.l_dep }}</td>
                        <td>{{ engagement.m_dispo }}</td>
                        <td>{{ engagement.m_toteng }}</td>
                        <td>{{ engagement.m_tengvi }}</td>
                        <td>{{ engagement.m_totliq }}</td>
                        <td>{{ engagement.m_tordvi }}</td>
                        <td>{{ engagement.m_totord }}</td>
                        <td>{{ engagement.m_dotini }}</td>
                        <td>{{ engagement.n_engage }}</td>
                        <td class="text-center">
                            <span class="badge badge-info">{{ engagement.m_engage|numFormat }}</span>
                        </td>
                        <td>{{ engagement.date_depot_ac }}</td>
                        <td>{{ engagement.date_paiement }}</td>
                        <td class="text-center">
                            <span class="badge badge-warning">{{ engagement.m_paye|numFormat }}</span>
                        </td>
                        <td>{{ engagement.d_engage }}</td>
                        <td>{{ engagement.mois_ }}</td>
                        <td>{{ engagement.m_tliqenga }}</td>
                        <td>{{ engagement.m_non_paye }}</td>
                        <td>{{ engagement.l_depeng }}</td>
                        <td>{{ engagement.l_nmtir }}</td>
                        <td>{{ engagement.n_mattir }}</td>
                        <td>{{ engagement.c_mattir }}</td>
                        <td>{{ engagement.l_chap }}</td>
                        <td>{{ engagement.n_devis }}</td>
                        <td>{{ engagement.nip }}</td>
                    </tr>
                    </tbody>
                    <tfoot>
                    <tr style="text-align: center;">
                        <th>#</th>
                        <th>d_exerci</th>
                        <th>c_dest</th>
                        <th>nat_dep</th>
                        <th>l_dep</th>
                        <th>m_dispo</th>
                        <th>m_toteng</th>
                        <th>m_tengvi</th>
                        <th>m_totliq</th>
                        <th>m_tordvi</th>
                        <th>m_totord</th>
                        <th>m_dotini</th>
                        <th>n_engage</th>
                        <th>m_engage</th>
                        <th>date_depot_ac</th>
                        <th>date_paiement</th>
                        <th>m_paye</th>
                        <th>d_engage</th>
                        <th>mois_</th>
                        <th>m_tliqenga</th>
                        <th>m_non_paye</th>
                        <th>l_depeng</th>
                        <th>l_nmtir</th>
                        <th>n_mattir</th>
                        <th>c_mattir</th>
                        <th>l_chap</th>
                        <th>n_devis</th>
                        <th>nip</th>
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

        <!-- /.modal -->
    </div>
</template>

<script>
    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        props : [],

        data(){
            return{
                engagements: [],
                providers: [],
                filter: {
                    devis: '',
                    year: {
                        start: '',
                        end: ''
                    },
                    provider: '',
                    status: ''
                },
                spinner: false,
                api_token: '',
                pagination: {
                    current_page: 1,
                    total: 0
                },
                years: [],
                exercice: 0

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.loadYears()
                this.fetchEngagements()
                this.fetchProviders()
            }

        },

        methods: {
            fetchEngagements(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&start=${this.filter.year.start}&end=${this.filter.year.end}&devis=${this.filter.devis}&provider=${this.filter.provider}&status=${this.filter.status}`

                let page_url = `/api/search?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.engagements = res.data
                        vm.makePagination(res.meta, res.links)
                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinner = false
                    });
            },
            fetchProviders(page_url) {
                let vm = this;

                page_url = page_url || `/api/providers?api_token=${this.api_token}`
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.providers = res.data
                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinnerProviders = false
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
                this.fetchEngagements();
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
            },
            selectStart(){
                this.filter.year.end = this.filter.year.start
            },
            selectEnd(){
                if(parseInt(this.filter.year.end) < parseInt(this.filter.year.start))
                    this.filter.year.end = this.filter.year.start
            }
        }

    }
</script>
