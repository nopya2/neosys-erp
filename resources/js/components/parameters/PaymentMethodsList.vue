<template>
    <div class="main-card mb-3 card">
        <div class="card-body">
            <h5 class="card-title">
                Modes de paiement ({{ payment_methods.length }})
                <div class="spinner-border spinner-border-sm" role="status" v-if="spinnerList">
                    <span class="sr-only">Loading...</span>
                </div>
                <button class="mb-2 mr-2 border-0 btn btn-transition btn-outline-success btn-sm float-right" title="Ajouter"
                    @click="addMethod('create')">
                    <i class="fa fa-plus"></i>
                </button>
            </h5>
            <table class="mb-0 table table-striped">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Intitulé</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-if="payment_methods.length <= 0">
                    <td colspan="3">Aucune methode paiement</td>
                </tr>
                <tr v-for="method in payment_methods">
                    <td>{{ method.id }}</td>
                    <td>{{ method.name }}</td>
                    <td class="text-center">
                        <button class="mb-2 mr-2 border-0 btn btn-transition btn-outline-warning btn-sm" title="Modifier"
                            @click="editMethod(method, 'update')">
                            <i class="fa fa-edit"></i>
                        </button>
                        <button class="mb-2 mr-2 border-0 btn btn-transition btn-outline-danger btn-sm" title="Supprimer"
                            @click="deleteMethod(method.id)">
                            <i class="fa fa-trash"></i>
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-end">
                    <li class="page-item" v-bind:class="[{disabled: !pagination.prev_page_url}]">
                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchMethods(pagination.prev_page_url)">Précédent</a>
                    </li>
                    <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                    <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                    <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                    <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                        <a class="page-link" href="javascript:" @click="fetchMethods(pagination.next_page_url)">Suivant</a>
                    </li>
                </ul>
            </nav>
        </div>

        <!-- Modal pour ajouter methodes de paiement -->
        <modal name="add-method" height="auto">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ajouter une méthode de paiement</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeModal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Nom</label>
                        <input type="text" class="form-control" name="name" placeholder="Tapez le nom" v-model="$v.method.name.$model" autocomplete="off"/>
                        <small class="form-text text-danger" v-if="!$v.method.name.required">Champs requis.</small>
                        <small class="form-text text-danger" v-if="!$v.method.name.minLength">Le nom doit avoir au moins {{ $v.method.name.$params.minLength.min }} caractères.</small>
                        <small class="form-text text-danger" v-if="!$v.method.name.maxLength">Le nom doit avoir au plus {{ $v.method.name.$params.maxLength.max }} caractères.</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="closeModal">Fermer</button>
                    <button type="button" class="btn btn-success" @click="saveMethod" :disabled="$v.method.$invalid" v-if="!spinnerSave"
                        v-bind:class="{'btn-success': action == 'create', 'btn-warning': action == 'update'}">
                        <span v-if="action == 'create'">Ajouter</span>
                        <span v-if="action == 'update'">Enregistrer</span>
                    </button>
                    <button class="btn btn-primary shadow-2" type="button" disabled="" v-if="spinnerSave">
                        <span class="spinner-grow spinner-grow-sm" role="status"></span>
                        Traitement en cours...
                    </button>
                </div>
            </div>
        </modal>
    </div>
</template>

<script>
    import { required, minLength, maxLength } from 'vuelidate/lib/validators'

    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        data(){
            return{
                payment_methods: [],
                method: {
                    name: ''
                },
                pagination: {
                    current_page: 1,
                    total: 0
                },
                spinnerList: false,
                spinner: false,
                spinnerSave: false,
                api_token: '',
                action: ''

            }
        },
        validations: {
            method: {
                name: {
                    required,
                    minLength: minLength(3),
                    maxLength: maxLength(50)
                }
            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchMethods()
            }

        },

        methods: {
            fetchMethods(page) {
                let vm = this;
                this.spinnerList = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.keyword}`
                let page_url = `/api/payment-methods?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinnerList = false
                        this.payment_methods = res.data
                        vm.makePagination(res.meta, res.links)
                    })
                    .catch(error => {
                        console.log(error)
                        this.spinnerList = false
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
            closeModal(){
                this.$modal.hide('add-method');
                this.method = {
                    name: ''
                }
            },
            addMethod(action){
                this.action = action;
                this.$modal.show('add-method')
            },
            saveMethod(){
                let method = 'POST';
                let icon = 'success';
                let title = 'Méthode de paiement ajoutée!';
                if(this.action === 'update') {
                    method = 'PUT';
                    icon = 'warning';
                    title = 'Modifications enregistrées!'
                }

                this.spinnerSave = true
                fetch(`/api/payment-method?api_token=${this.api_token}`, {
                    method: method,
                    body: JSON.stringify(this.method),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        if(this.action === 'create') this.fetchMethods();
                        if(this.action === 'update'){
                            let method = res.data;
                            let index = this.payment_methods.findIndex(x => x.id === method.id);
                            this.payment_methods[index] = method;
                        }
                        this.spinnerSave = false;
                        this.closeModal();
                        this.$swal({
                            position: 'top-end',
                            icon: icon,
                            title: title,
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })


                    })
                    .catch(error => {
                        this.spinnerSave = false
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
            editMethod(method, action){
                this.action = action;
                this.method = {...method};
                this.$modal.show('add-method');
            },
            deleteMethod(id){

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`api/payment-method/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                            icon: 'error',
                            title: 'Cette méthode a été supprimée',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                        this.fetchMethods();
                    }
                })
            },
        }

    }
</script>
