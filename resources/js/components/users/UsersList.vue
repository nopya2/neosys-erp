<template>
    <div class="row">
        <div class="col-lg-12">
            <div class="row mb-2">
                <div class="col-md-6">
                    <button type="button" class="btn btn-success btn-sm" @click="create">
                        <i class="fa fa-plus-circle"></i> Ajouter un utilisateur
                    </button>
                </div>
                <div class="col-md-4 offset-md-2">
                    <div class="form-group">
                        <!--<label></label>-->
                        <input type="text" class="form-control" placeholder="Tapez votre recherche" aria-label="Recipient's username"
                               aria-describedby="basic-addon2" v-model="keyword" v-on:keyup="search">
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
                            {{ pagination.total }} Utilisateur{{ (pagination.total > 1)? 's': ''}}
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped" id="example1">
                                <thead>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>Nom</th>
                                    <th>Prenom</th>
                                    <th>Nom d'utilisateur</th>
                                    <th>E-mail</th>
                                    <th>Role</th>
                                    <th>Statut</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="(user, index) in users" v-bind:key="user.id">
                                    <td>{{ user.id }}</td>
                                    <td>{{ user.name }}</td>
                                    <td>{{ user.firstname }}</td>
                                    <td>{{ user.username }}</td>
                                    <td>{{ user.email }}</td>
                                    <td>{{ user.role }}</td>
                                    <td class="text-center">
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" :id="'customCheck'+user.id" name="status" v-bind:checked="user.status"
                                                       @change="changeStatus(user, $event)">
                                                <label class="custom-control-label" :for="'customCheck'+user.id">
                                                    <!--<span data-toggle="tooltip" title="Activé" v-if="user.status">Activé</span>-->
                                                    <!--<span data-toggle="tooltip" title="Désactivé" v-if="!user.status">Désactivé</span>-->
                                                </label>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <a :href="'user/'+user.id+'/edit'">
                                            <button class="btn btn-warning btn-icon btn-xs" title="Modifier">
                                                <i class="fa fa-edit"></i>
                                            </button>
                                        </a>
                                        <button class="btn btn-icon btn-danger btn-xs" title="Supprimer" @click="deleteUser(user.id)">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>Nom</th>
                                    <th>Prenom</th>
                                    <th>Nom d'utilisateur</th>
                                    <th>E-mail</th>
                                    <th>Role</th>
                                    <th>Statut</th>
                                    <th></th>
                                </tr>
                                </tfoot>
                            </table>

                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end">
                                    <li class="page-item" v-bind:class="[{disabled: !pagination.prev_page_url}]">
                                        <a class="page-link" href="javascript:" tabindex="-1" @click="fetchUsers(pagination.prev_page_url+'&api_token='+api_token)">Précédent</a>
                                    </li>
                                    <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                                    <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                    <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                    <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                                        <a class="page-link" href="javascript:" @click="fetchUsers(pagination.next_page_url+'&api_token='+api_token)">Suivant</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <v-dialog/>
    </div>

</template>

<script>
    // $(function () {
    //     $("#example1").DataTable();
    // });
    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        props : ['user_role'],

        data(){
            return{
                users: [],
                title: '',
                description: '',
                keyword: '',
                spinner: false,
                api_token: '',
                pagination: {
                    current_page: 1,
                    total: 0
                },

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchUsers()
            }

        },

        methods: {
            fetchUsers(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.keyword}`
                let page_url = `/api/users?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.users = res.data
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
            create(){
                window.location = '/user/create';
            },
            search(){
                this.fetchUsers();
            },
            deleteUser(id){
                let vm = this;

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`api/user/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                            title: 'Cet utilisateur a été supprimé',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                        vm.fetchUsers();
                    }
                })
            },
            changeStatus(user, event){
                let data = {
                    user: user.id,
                    status: event.target.checked
                }

                fetch(`api/user/change-status?api_token=${this.api_token}`, {
                    method: 'post',
                    body: JSON.stringify(data),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json)
                    .then(data => {
                        this.$swal({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Statut modifié!',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                    })
                    .catch(error => {
                        console.log(error)
                        this.$toast.open({
                            message: "Erreur modification du statut!",
                            type: "error",
                            duration: 5000,
                            dismissible: true,
                            position: 'top-right'
                        })
                    });
            }
        }

    }
</script>
