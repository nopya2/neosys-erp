<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <button type="button" class="btn btn-success btn-sm" @click="addTax">
                        <i class="fa fa-plus-circle"></i> Ajouter une taxe
                    </button>
                </div>
                <div class="col-md-4 offset-md-2">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Tapez votre recherche" aria-label="Recipient's customername"
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
                            {{ pagination.total }} Taxe{{ (pagination.total > 1)? 's': ''}}
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr style="text-align: center;">
                                    <th>ID</th>
                                    <th>Nom</th>
                                    <th>Taux(%)</th>
                                    <th>Par défaut</th>
                                    <th>Description</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="(tax) in taxes">
                                    <td class="text-center">{{ tax.id }}</td>
                                    <td>{{ tax.name }}</td>
                                    <td class="text-center">{{ tax.value }}</td>
                                    <td class="text-center">
                                        <div class="badge badge-success" v-if="tax.enabled">Activé</div>
                                        <div class="badge badge-secondary" v-if="!tax.enabled">Désactivé</div>
                                    </td>
                                    <td>{{ tax.description }}</td>
                                    <td class="text-center">
                                        <button class="btn btn-warning btn-icon btn-sm" title="Modifier" @click="editTax(tax)">
                                            <i class="fa fa-edit"></i>
                                        </button>
                                        <button class="btn btn-icon btn-danger btn-sm" title="Supprimer" @click="deleteTax(tax.id)">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                                <tr style="text-align: center;">
                                    <th>ID</th>
                                    <th>Nom</th>
                                    <th>Taux(%)</th>
                                    <th>Par défaut</th>
                                    <th>Description</th>
                                    <th></th>
                                </tr>
                            </table>
                        </div>

                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-end">
                                <li class="page-item" v-bind:class="[{disabled: !pagination.prev_page_url}]">
                                    <a class="page-link" href="javascript:" tabindex="-1" @click="fetchTaxes(pagination.prev_page_url)">Précédent</a>
                                </li>
                                <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                                <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                                    <a class="page-link" href="javascript:" @click="fetchTaxes(pagination.next_page_url)">Suivant</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

        <modal name="add-item" height="auto">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">{{ modal_title }}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeModal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-row">
                        <div class="col-md-12">
                            <div class="position-relative form-group">
                                <label for="name" class="name">Nom</label>
                                <input name="name" id="name" placeholder="Le nom" type="text" class="form-control" v-model="$v.new_item.name.$model">
                                <small class="form-text text-danger" v-if="!$v.new_item.name.required">Champs requis.</small>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-12">
                            <div class="position-relative form-group">
                                <label for="value" class="">Taux</label>
                                <input name="value" id="value" placeholder="0.00" type="number" class="form-control" v-model="$v.new_item.value.$model">
                                <small class="form-text text-danger" v-if="!$v.new_item.value.required">Champs requis.</small>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-12">
                            <div class="position-relative form-group">
                                <label for="description" class="">Description</label>
                                <textarea name="description" id="description" placeholder="" class="form-control" v-model="$v.new_item.description.$model"></textarea>
                                <small class="form-text text-danger" v-if="!$v.new_item.description.required">Champs requis.</small>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="custom-checkbox custom-control">
                            <input type="checkbox" id="exampleCustomCheckbox" class="custom-control-input" v-model="$v.new_item.enabled.$model" v-bind:checked="new_item.enabled">
                            <label class="custom-control-label" for="exampleCustomCheckbox">Par défaut</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal">Annuler</button>
                    <button type="button" class="btn btn-success" :disabled="$v.new_item.$invalid" @click="saveTax" v-if="!btnLoading && modal_action=='add'">Ajouter</button>
                    <button type="button" class="btn btn-warning" :disabled="$v.new_item.$invalid" @click="saveTax" v-if="!btnLoading && modal_action=='edit'">Enregistrer</button>
                    <button class="btn btn-primary shadow-2" type="button" disabled="" v-if="btnLoading">
                        <span class="spinner-grow spinner-grow-sm" role="status"></span>
                        Traitement en cours
                    </button>
                </div>
            </div>
        </modal>
    </div>
</template>

<script>
    import { required } from 'vuelidate/lib/validators'

    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        data(){
            return{
                taxes: [],
                pagination: {
                    current_page: 1,
                    total: 0
                },
                title: '',
                description: '',
                keyword: '',
                spinner: false,
                api_token: '',
                new_item: {
                    name: '',
                    value: 0.0,
                    description: "",
                    enabled: false
                },
                modal_action: '',
                modal_title: '',
                btnLoading: false

            }
        },
        validations: {
            new_item: {
                name: {
                    required
                },
                value: {
                    required
                },
                description: {
                    required
                },
                enabled:{

                }

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchTaxes()
            }

        },

        methods: {
            fetchTaxes(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.keyword}`
                let page_url = `/api/taxes?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.taxes = res.data
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
            addTax(){
                this.modal_action = 'add'
                this.new_item = {
                    name: '',
                    value: 0.0,
                    description: "",
                    enabled: false
                }
                this.modal_title = 'Ajouter une taxe'
                this.$modal.show('add-item')

            },
            editTax(tax){
                this.modal_title = 'Modifier la taxe'
                this.modal_action = 'edit'
                this.new_item = { ...tax }
                this.$modal.show('add-item');
            },
            saveTax(){
                this.btnLoading = true
                let method = 'POST'
                let icon = 'success'
                let title = 'La taxe a été ajoutée!'
                if(this.modal_action == 'add'){
                    method = 'POST'
                    icon = 'success'
                    title = 'La taxe a été ajoutée!'
                }else if(this.modal_action == 'edit'){
                    method = 'PUT'
                    icon = 'warning'
                    title = 'Modifications enregistrées!'
                }

                fetch(`/api/tax?api_token=${this.api_token}`, {
                    method: method,
                    body: JSON.stringify(this.new_item),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json)
                    .then(data => {
                        this.btnLoading = false
                        this.$modal.hide('add-item');
                        this.$swal({
                            position: 'top-end',
                            icon: icon,
                            title: title,
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })

                        this.fetchTaxes()
                    })
                    .catch(error => {
                        this.btnLoading = false
                        this.$swal({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Erreur traitement!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    });
            },
            closeModal(){
                this.$modal.hide('add-item');
            },
            search(){
                this.fetchTaxes();
            },
            deleteTax(id){
                let vm = this;

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`api/tax/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                            title: 'Cette taxe a été supprimée',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                        vm.fetchTaxes();
                    }
                })

            },
            edit(tax){

            }
        }

    }
</script>
