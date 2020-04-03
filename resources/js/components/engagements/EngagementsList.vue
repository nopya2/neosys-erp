<template>
    <div class="card-block table-border-style">
        <div class="row mb-2">
            <div class="col-md-3">
                <button type="button" class="btn btn-success btn-sm" @click="openImportForm">
                    <i class="fa fa-upload"></i> Importer engagements
                </button>
            </div>
            <div class="col-md-9">
                <div class="row">
                    <div class="col-sm-2">
                        <div class="form-group">
                            <label>Exercice</label>
                            <select class="form-control form-control-sm" v-model="filter.exercice" @change="search">
                                <option v-for="(year, index) in years" v-bind:value="year">{{ year }}</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Tapez votre recherche</label>
                            <input type="text" class="form-control form-control-sm" placeholder="Tapez votre recherche" v-model="filter.keyword" v-on:keyup="search">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Statut</label>
                            <select class="form-control form-control-sm" v-model="filter.status" @change="search">
                                <option value="">Tout</option>
                                <option value="non_paye">Non payé</option>
                                <option value="paye">Payé</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Ordre montant engagé</label>
                            <select class="form-control form-control-sm" v-model="filter.order" @change="search">
                                <option value="">Aucun</option>
                                <option value="asc">Du plus petit au plus grand</option>
                                <option value="desc">Du plus grand au plus petit</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group clearfix">
                            <div class="icheck-primary d-inline">
                                <input type="checkbox" id="checkboxPrimary2" v-model="filter.is_late" @change="search">
                                <label for="checkboxPrimary2">
                                    En retard
                                </label>
                            </div>
                        </div>
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
                        <tr v-for="(engagement, index) in engagements" v-bind:key="engagement.id" v-bind:class="{ 'bg-success':  engagement.is_paid}">
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

        <div class="modal fade" id="modal-default">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Importer engagements</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeImport">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="exampleInputFile">Fichier à importer</label>
                            <div class="input-group">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="exampleInputFile" @change="uploadFile" ref="file">
                                    <label class="custom-file-label" for="exampleInputFile">{{ file.name }}</label>
                                </div>
                                <div class="input-group-append">
                                    <span class="input-group-text" id=""><i class="fa fa-upload"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Exercice</label>
                            <select class="form-control" v-model="exercice">
                                <option v-for="(year, index) in years" v-bind:value="year">{{ year }}</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-default" data-dismiss="modal" @click="closeImport">Annuler</button>
                        <button type="button" class="btn btn-primary" :disabled="file.size <= 0" @click="importFile" v-if="!btnLoading">Importer</button>
                        <button class="btn btn-primary shadow-2" type="button" disabled="" v-if="btnLoading">
                            <span class="spinner-grow spinner-grow-sm" role="status"></span>
                            Traitement...
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
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
                file: {
                    name: 'Sélectionnez un fichier',
                    size: 0
                },
                filter: {
                    keyword: '',
                    exercice: '',
                    is_late: false,
                    status: '',
                    order: ''
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
                this.fetchEngagements()
            }

        },

        methods: {
            fetchEngagements(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.filter.keyword}&exercice=${this.filter.exercice}&late=${this.filter.is_late}&status=${this.filter.status}&order=${this.filter.order}`

                let page_url = `/api/engagements?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.engagements = res.data
                        let meta = {
                            current_page: res.current_page,
                            total: res.total,
                            last_page: res.last_page,
                        }

                        let links = {
                            next: res.next_page_url,
                            prev: res.prev_page_url,
                        }
                        vm.makePagination(meta, links)
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

                console.log(this.pagination)
            },
            openImportForm(){
                $('#modal-default').modal({
                    show: true,
                    backdrop: 'static'
                })
            },
            search(){
                this.fetchEngagements();
            },
            uploadFile(event){
                // console.log(event.target.files[0])
                this.file = event.target.files[0]
            },
            closeImport(){
                // this.file.name = 'Sélectionnez un fichier'
                // this.file.size = 0
            },
            importFile(){
                this.btnLoading = true
                let formData = new FormData()
                this.filter.exercice = this.exercice
                formData.append('file', this.file)
                formData.append('exercice', this.exercice)
                fetch(`/api/engagements/import?api_token=${this.api_token}`, {
                    method: 'post',
                    body: formData
                })
                    .then(res => res.json())
                    .then(res => {
                        this.btnLoading = false
                        $('#modal-default').modal('hide')
                        toastr.success('Engagements importés!.')
                        this.fetchEngagements()
                    })
                    .catch(error => {
                        this.btnLoading = false
                        toastr.error('Erreur import du fichier!.')
                        this.spinner = false
                    });
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
