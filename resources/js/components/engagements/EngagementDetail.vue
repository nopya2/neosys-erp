<template>
    <div class="row">
        <div class="col-md-6">
            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">Détails de l'engagement</h3>
                </div>
                <div class="card-body" style="max-height: 600px; overflow: scroll">

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_engage</label>
                                <input type="text" class="form-control bg-info" readonly :value="engagement.m_engage|numFormat">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_paye</label>
                                <input type="text" class="form-control bg-success" readonly :value="engagement.m_paye|numFormat">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_non_paye</label>
                                <input type="text" class="form-control bg-warning" readonly :value="engagement.m_non_paye|numFormat">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>d_exerci</label>
                                <input type="text" class="form-control" readonly :value="engagement.d_exerci">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>nat_dep</label>
                                <input type="text" class="form-control" readonly :value="engagement.nat_dep">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>l_dep</label>
                                <input type="text" class="form-control" readonly :value="engagement.l_dep">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_dispo</label>
                                <input type="text" class="form-control" readonly :value="engagement.m_dispo">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_toteng</label>
                                <input type="text" class="form-control" readonly :value="engagement.m_toteng">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_tengvi</label>
                                <input type="text" class="form-control" readonly :value="engagement.m_tengvi">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_totliq</label>
                                <input type="text" class="form-control" readonly :value="engagement.m_totliq">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_tordvi</label>
                                <input type="text" class="form-control" readonly :value="engagement.m_tordvi">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_totord</label>
                                <input type="text" class="form-control" readonly :value="engagement.m_totord">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_dotini</label>
                                <input type="text" class="form-control" readonly :value="engagement.m_dotini">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>n_engage</label>
                                <input type="text" class="form-control" readonly :value="engagement.n_engage">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>date_paiement</label>
                                <input type="text" class="form-control" readonly :value="engagement.date_paiement">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>date_depot_ac</label>
                                <input type="text" class="form-control" readonly :value="engagement.date_depot_ac">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>d_engage</label>
                                <input type="text" class="form-control" readonly :value="engagement.d_engage">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>mois_</label>
                                <input type="text" class="form-control" readonly :value="engagement.mois_">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>m_tliqenga</label>
                                <input type="text" class="form-control" readonly :value="engagement.m_tliqenga">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>c_dest</label>
                                <input type="text" class="form-control" readonly :value="engagement.c_dest">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>l_depeng</label>
                                <input type="text" class="form-control" readonly :value="engagement.l_depeng">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>l_nmtir</label>
                                <input type="text" class="form-control" readonly :value="engagement.l_nmtir">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>n_mattir</label>
                                <input type="text" class="form-control" readonly :value="engagement.n_mattir">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>c_mattir</label>
                                <input type="text" class="form-control" readonly :value="engagement.c_mattir">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>l_chap</label>
                                <input type="text" class="form-control" readonly :value="engagement.l_chap">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>n_devis</label>
                                <input type="text" class="form-control" readonly :value="engagement.n_devis">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card card-warning">
                <div class="card-header">
                    <h3 class="card-title">Tableau des paiements</h3>
                </div>
                <div class="card-body">
                    <div class="row mb-2">
                        <div class="col-md-12">
                            <button type="button" class="btn btn-success btn-sm" @click="openPaiementForm" :disabled="engagement.m_engage <= 0">
                                <i class="fa fa-plus"></i> &nbsp;Ajouter paiement
                            </button>
                            <span class="text-danger" v-if="engagement.m_engage <= 0">
                                <small>Vous ne pouvez pas effectuer de paiements, aucun montant n'est engagé!</small>
                            </span>
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
                                    <th>m_paye</th>
                                    <th>date_paiement</th>
                                    <th>date_depot_ac</th>
                                    <th>Commentaire</th>
                                </tr>
                                </thead>
                                <tbody style="font-size: 14px">
                                <tr v-for="echelon in echelons">
                                    <td>{{ echelon.id }}</td>
                                    <td>{{ echelon.m_paye|numFormat }}</td>
                                    <td>{{ echelon.date_paiement }}</td>
                                    <td>{{ echelon.date_depot_ac }}</td>
                                    <td>{{ echelon.comment }}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="modal fade" id="modal-default">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Ajouter paiement</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeImport">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>m_paye</label>
                                        <input type="number" class="form-control" name="m_paye" v-model.trim="$v.echelon.m_paye.$model"/>
                                    </div>
                                    <div class="form-group">
                                        <label>date_paiement</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                            </div>
                                            <input type="text" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask ref="date_paiement">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>date_depot_ac</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                            </div>
                                            <input type="text" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask ref="date_depot_ac">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Commentaire</label>
                                        <textarea rows="4" class="form-control" name="comment" v-model.trim="$v.echelon.comment.$model"></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer justify-content-between">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" @click="closeImport">Annuler</button>
                                    <button type="button" class="btn btn-success" :disabled="$v.echelon.$invalid" @click="addPaiement" v-if="!btnLoading">Ajouter</button>
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
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import { required, minLength, maxLength, between, email, sameAs, maxValue } from 'vuelidate/lib/validators';

    export default {
        mounted() {
            // console.log('Component mounted.')
            //Datemask dd/mm/yyyy
            $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
            //Datemask2 mm/dd/yyyy
            $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
            //Money Euro
            $('[data-mask]').inputmask()

            $(function () {

            })
        },

        props : ['n_engage', 'engagement_id'],

        data(){
            return{
                engagement: {},
                echelons: [],
                echelon: {
                    m_paye: null,
                    date_paiement: null,
                    date_depot_ac: null,
                    n_engage: '',
                    comment: ''
                },
                spinner: false,
                api_token: '',
                btnLoading: false,

            }
        },
        validations: {
            echelon: {
                m_paye: {
                    required,
                    maxValue
                },
                date_paiement: {
                    // required
                },
                date_depot_ac: {
                    // required
                },
                comment: {
                    required
                }
            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchEngagement()
                this.fetchEchelons()
            }

            this.echelon.n_engage = this.n_engage

        },

        methods: {
            fetchEngagement(page_url){
                let vm = this;
                this.spinner = true;

                page_url = page_url || `/api/engagements/${this.engagement_id}?api_token=${this.api_token}&n_engage=${this.n_engage}`
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.engagement = res.data
                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinner = false
                    });
            },
            fetchEchelons(page_url) {
                let vm = this;
                this.spinner = true;

                page_url = page_url || `/api/echelons/select-by-engagement-number?api_token=${this.api_token}&n_engage=${this.n_engage}`
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.echelons = res.data
                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinner = false
                    });
            },
            openPaiementForm(){
                $('#modal-default').modal({
                    show: true,
                    backdrop: 'static'
                })
            },
            closeImport(){
                this.echelon.m_paye = null
            },
            addPaiement(){
                this.echelon.date_paiement =  this.$refs.date_paiement.value
                this.echelon.date_depot_ac =  this.$refs.date_depot_ac.value;
                this.btnLoading = true

                fetch(`/api/echelon?api_token=${this.api_token}`, {
                    method: 'post',
                    body: JSON.stringify(this.echelon),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json)
                    .then(data => {
                        this.btnLoading = false
                        $('#modal-default').modal('hide')
                        toastr.success('paiement ajouté!')
                        this.fetchEngagement()
                        this.fetchEchelons()
                        this.echelon.m_paye = null
                    })
                    .catch(error => {
                        this.btnLoading = false
                        toastr.error('Erreur import du fichier!.')
                    });
            }
        }

    }
</script>

<style>
    .form-control[readonly] {
        background-color: white;
        opacity: 1;
    }
</style>