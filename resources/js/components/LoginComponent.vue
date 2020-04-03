<template>
    <div class="row">
        <div class="col-md-3" style="margin: auto">
            <div class="card">
                <div class="card-body login-card-body">
                    <!--<p class="login-box-msg">Se connecter à votre session</p>-->
                    <div class="row text-center mt-5 mb-5">
                        <div class="col-md-12 ">
                            <img v-bind:src="'img/logo.png'" width="250" height="auto"/>
                        </div>
                    </div>

                    <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="showMessageError">
                        <strong>Erreur connexion!</strong> Login ou Mot de passe incorrect.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                    </div>

                    <div class="alert alert-success alert-dismissible fade show" role="alert" v-if="showMessageSuccess">
                        <strong>Connexion réussie!</strong>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                    </div>

                    <form method="POST" action="/login" id="login-form" v-on:submit.prevent="loginSubmit">
                        <input type="hidden" v-bind:value="csrfToken" name="_token"/>
                        <div class="input-group mb-3 mt-3">
                            <input type="text" class="form-control" placeholder="Login" name="login"
                                   required autocomplete="login" autofocus v-model="user.login">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-envelope"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="password" class="form-control" placeholder="Mot de passe" name="password"
                                   required v-model="user.password">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <div class="icheck-primary">
                                    <input type="checkbox" id="remember" checked="" name="remember">
                                    <label for="remember">
                                        Se souvenir de moi
                                    </label>
                                </div>
                            </div>
                            <!-- /.col -->
                            <div class="col-6">
                                <button type="submit" class="btn btn-primary btn-block" @click="loginSubmit" v-if="btnSubmit">Se connecter</button>
                                <button class="btn btn-primary btn-block shadow-2" type="button" disabled="" v-if="btnLoading">
                                    <span class="spinner-grow spinner-grow-sm" role="status"></span>
                                    Connexion en cours...
                                </button>
                            </div>
                            <!-- /.col -->
                        </div>
                    </form>

                    <p class="mb-5">
                        <a href="forgot-password.html">Mot de passe oublié?</a>
                    </p>
                </div>
                <!-- /.login-card-body -->
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            console.log('Component mounted.')
        },

        data(){
            return{
                user: {
                    login: '',
                    password: ''
                },
                csrfToken: null,
                btnSubmit: true,
                btnLoading: false,
                showMessageError: false,
                showMessageSuccess: false
            }
        },

        created(){
            this.csrfToken = document.querySelector('meta[name="csrf-token"]').content
        },

        methods: {
            loginSubmit(){
                const authUser = {}
                this.btnSubmit = false
                this.btnLoading = true
                this.showMessageError = false

                fetch('/api/oauth', {
                    method: 'POST',
                    body: JSON.stringify(this.user),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json())
                    .then(res => {
                        if(res.data){
                            this.showMessageSuccess = true
                            authUser.api_token = res.data.api_token
                            window.localStorage.setItem('authUser', JSON.stringify(authUser))
                            document.getElementById('login-form').submit()
                        }else{
                            this.showMessageError = true
                            this.btnSubmit = true
                            this.btnLoading = false
                        }
                    })
                    .catch(error => {
                        this.showMessageError = true
                        this.btnSubmit = true
                        this.btnLoading = false
                        console.log(error)
                    });
            }
        }
    }
</script>
