<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <button type="button" class="btn btn-success btn-sm" @click="create">
                        <i class="fa fa-plus-circle"></i> Ajouter un client
                    </button>
                </div>
                <div class="col-md-4 offset-md-2">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Tapez votre recherche" aria-label="Recipient's customername"
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
                            {{ pagination.total }} Client{{ (pagination.total > 1)? 's': ''}}
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>Nom de l'entreprise</th>
                                    <th>Adresse</th>
                                    <th>E-mail</th>
                                    <th>Téléphone</th>
                                    <th>Activité</th>
                                    <th>Utilisateur</th>
                                    <!--<th>Role</th>-->
                                    <!--<th>E-mail</th>-->
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="(customer) in customers">
                                    <td>{{ customer.id }}</td>
                                    <td>{{ customer.company_name }}</td>
                                    <td>{{ customer.address }}</td>
                                    <td>{{ customer.email }}</td>
                                    <td>{{ customer.phonenumber }}</td>
                                    <td>{{ customer.activity }}</td>
                                    <td>
                                        <span v-if="customer.manager">{{ customer.manager.name }}</span>
                                    </td>
                                    <td class="text-center">
                                        <a :href="'customer/'+customer.id+'/edit'">
                                            <button class="btn btn-warning btn-icon btn-sm" title="Modifier">
                                                <i class="fa fa-edit"></i>
                                            </button>
                                        </a>
                                        <button class="btn btn-icon btn-danger btn-sm" title="Supprimer" @click="deleteCustomer(customer.id)">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                                <tr style="text-align: center;">
                                    <th>#</th>
                                    <th>Nom de l'entreprise</th>
                                    <th>Adresse</th>
                                    <th>E-mail</th>
                                    <th>Téléphone</th>
                                    <th>Activité</th>
                                    <th>Utilisateur</th>
                                    <th></th>
                                </tr>
                            </table>
                        </div>

                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-end">
                                <li class="page-item" v-bind:class="[{disabled: !pagination.prev_page_url}]">
                                    <a class="page-link" href="javascript:" tabindex="-1" @click="fetchCustomers(pagination.prev_page_url)">Précédent</a>
                                </li>
                                <li class="page-item disabled"><a class="page-link" href="javascript:">{{ pagination.current_page }}</a></li>
                                <!--<li class="page-item"><a class="page-link" href="#!">2</a></li>-->
                                <!--<li class="page-item"><a class="page-link" href="#!">3</a></li>-->
                                <li class="page-item" v-bind:class="[{disabled: !pagination.next_page_url}]">
                                    <a class="page-link" href="javascript:" @click="fetchCustomers(pagination.next_page_url)">Suivant</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        data(){
            return{
                customers: [],
                pagination: {
                    current_page: 1,
                    total: 0
                },
                title: '',
                description: '',
                keyword: '',
                spinner: false,
                api_token: ''

            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchCustomers()
            }

        },

        methods: {
            fetchCustomers(page) {
                let vm = this;
                this.spinner = true;

                let url_parameters = `api_token=${this.api_token}&keyword=${this.keyword}`
                let page_url = `/api/customers?${url_parameters}`
                if(page) page_url = `${page}&${url_parameters}`

                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.customers = res.data
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
                    last_page: meta.last_page,
                    next_page_url: links.next,
                    prev_page_url: links.prev,
                    total: meta.total
                }

                this.pagination = pagination;
            },
            create(){
                window.location = '/customer/create';
            },
            search(){
                this.fetchCustomers();
            },
            deleteCustomer(id){
                let vm = this;

                this.$swal({
                    title: 'Supprimer',
                    text: 'Etes-vous sur de vouloir supprimer?',
                    showCancelButton: true,
                    confirmButtonText: 'Supprimer',
                    confirmButtonColor: '#C82333',
                    showLoaderOnConfirm: true,
                    preConfirm: (login) => {
                        return fetch(`api/customer/${id}?api_token=${this.api_token}`, { method: 'delete' })
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
                            title: 'Ce client a été supprimé',
                            showConfirmButton: false,
                            timer: 5000,
                            toast: true
                        })
                        vm.fetchCustomers();
                    }
                })

            },
        }

    }
</script>
