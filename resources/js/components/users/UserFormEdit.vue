<template>
    <form method="POST" :action="`/user/${user.id}/edit`">
        <input type="hidden" :value="csrfToken" name="_token"/>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="name">Nom <span class="text-danger">(*)</span></label>
                <input type="text" class="form-control" id="name" placeholder="Nom" v-model.trim="$v.user.name.$model" name="name">
                <small class="form-text text-danger" v-if="!$v.user.name.required">Champs requis.</small>
                <small class="form-text text-danger" v-if="!$v.user.name.minLength">{{$v.user.name.$params.minLength.min}} caractères minimum.</small>
                <small class="form-text text-danger" v-if="!$v.user.name.maxLength">{{$v.user.name.$params.maxLength.max}} caractères maximum.</small>
            </div>
            <div class="form-group col-md-6">
                <label for="firstname">Prénom <span class="text-danger">(*)</span></label>
                <input type="text" class="form-control" id="firstname" placeholder="Prénom" v-model.trim="$v.user.firstname.$model" name="firstname">
                <small class="form-text text-danger" v-if="!$v.user.firstname.required">Champs requis.</small>
                <small class="form-text text-danger" v-if="!$v.user.firstname.minLength">{{$v.user.firstname.$params.minLength.min}} caractères minimum.</small>
                <small class="form-text text-danger" v-if="!$v.user.firstname.maxLength">{{$v.user.firstname.$params.maxLength.max}} caractères maximum.</small>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="username">Nom d'utilisateur <span class="text-danger">(*)</span></label>
                <input type="text" class="form-control" id="username" placeholder="Nom d'utilisateur" v-model.lazy="user.username" name="username"
                   @blur="$v.user.username.$touch()">
                <small class="form-text text-danger" v-if="!$v.user.username.required">Champs requis.</small>
                <small class="form-text text-danger" v-if="!$v.user.username.minLength">{{$v.user.username.$params.minLength.min}} caractères minimum.</small>
                <small class="form-text text-danger" v-if="!$v.user.username.maxLength">{{$v.user.username.$params.maxLength.max}} caractères maximum.</small>
                <small class="form-text text-danger" v-if="!$v.user.username.isUnique">Ce nom d'utilisateur est déjà utilisé</small>
            </div>
            <div class="form-group col-md-6">
                <label for="email">E-mail <span class="text-danger">(*)</span></label>
                <input type="email" class="form-control" id="email" placeholder="E-mail" v-model.trim="$v.user.email.$model" name="email">
                <small class="form-text text-danger" v-if="!$v.user.email.email">E-mail invalide.</small>
                <small class="form-text text-danger" v-if="!$v.user.email.isUnique">Cet email est déjà utilisé</small>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="role">Role <span class="text-danger">(*)</span></label>
                <select id="role" class="form-control" v-model.trim="$v.user.role.$model" name="role">
                    <option value="">--- Sélectionnez un role ---</option>
                    <option value="manager">Gestionnaire</option>
                    <option value="admin">Administrateur</option>
                </select>
                <small class="form-text text-danger" v-if="!$v.user.role.required">Champs requis.</small>
            </div>
            <div class="form-group col-md-6">
                <label for="phonenumber">Téléphone</label>
                <input type="text" class="form-control" id="phonenumber" placeholder="" v-model.trim="$v.user.phonenumber.$model" name="phonenumber">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="fonction">Fonction</label>
                <input type="text" class="form-control" id="fonction" placeholder="" v-model.trim="$v.user.fonction.$model" name="fonction">
            </div>
        </div>
        <div class="form-group">
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="customCheck1" name="status" v-bind:checked="user.status">
                <label class="custom-control-label" for="customCheck1">Activé</label>
            </div>
        </div>
        <button type="submit" class="btn btn-warning" :disabled="$v.user.$invalid">
            <i class="fa fa-save"></i>&nbsp;Enregistrer
        </button>


        <button type="button" class="btn btn-primary float-right" @click="openModal">
            <i class="fa fa-save"></i>&nbsp;Réinitialiser le mot de passe
        </button>

        <modal name="reset-password">
            <div class="row p-3">
                <div class="col-md-12">
                    <div class="form-group">
                        <label>Tapez le nouveau mot de passe</label>
                        <input type="password" class="form-control" name="m_paye" v-model.trim="$v.password.new.$model"/>
                        <small class="form-text text-danger" v-if="!$v.password.new.required">Champs requis.</small>
                    </div>

                    <div class="form-group">
                        <label>Retapez le mot de passe</label>
                        <input type="password" class="form-control" name="m_paye" v-model.trim="$v.password.repeat.$model"/>
                        <small class="form-text text-danger" v-if="!$v.password.repeat.sameAsPassword">Les mots de passe doivent etre identique.</small>
                    </div>
                </div>
            </div>
            <div class="row p-3">
                <div class="col-md-6">
                    <button type="button" class="btn btn-danger btn-block" @click="closeModal">Annuler</button>
                </div>
                <div class="col-md-6">
                    <button type="button" class="btn btn-success btn-block" :disabled="$v.password.$invalid" @click="savePassword" v-if="!btnLoading">Enregistrer</button>
                    <button class="btn btn-primary shadow-2 btn-block" type="button" disabled="" v-if="btnLoading">
                        <span class="spinner-grow spinner-grow-sm" role="status"></span>
                        Traitement en cours...
                    </button>
                </div>
            </div>
        </modal>

        <div class="modal fade" id="modal-default">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Réinitialiser le mot de passe</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="closeModal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Tapez le nouveau mot de passe</label>
                            <input type="password" class="form-control" name="m_paye" v-model.trim="$v.password.new.$model"/>
                            <small class="form-text text-danger" v-if="!$v.password.new.required">Champs requis.</small>
                        </div>
                        <div class="form-group">
                            <label>Retapez le mot de passe</label>
                            <input type="password" class="form-control" name="m_paye" v-model.trim="$v.password.repeat.$model"/>
                            <small class="form-text text-danger" v-if="!$v.password.repeat.sameAsPassword">Les mots de passe doivent etre identique.</small>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-default" data-dismiss="modal" @click="closeModal">Annuler</button>
                        <button type="button" class="btn btn-success" :disabled="$v.password.$invalid" @click="savePassword" v-if="!btnLoading">Enregistrer</button>
                        <button class="btn btn-primary shadow-2" type="button" disabled="" v-if="btnLoading">
                            <span class="spinner-grow spinner-grow-sm" role="status"></span>
                            Traitement en cours...
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </form>

</template>

<script>
    import { required, minLength, maxLength, between, email, sameAs } from 'vuelidate/lib/validators';

    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        props : ['user_id'],

        data(){
            return{
                user: {
                    id: 0,
                    name: '',
                    firstname: '',
                    username: '',
                    email: '',
                    role: "",
                    phonenumber: '',
                    status: true,
                    fonction: ''
                },
                password: {
                    new: '',
                    repeat: ''
                },
                spinner: false,
                csrfToken: null,
                api_token: '',
                btnLoading: false,

            }
        },
        validations: {
            user: {
                name: {
                    required,
                    minLength: minLength(3),
                    maxLength: maxLength(50),
                },
                firstname: {
                    required,
                    minLength: minLength(3),
                    maxLength: maxLength(50),
                },
                username: {
                    required,
                    minLength: minLength(3),
                    maxLength: maxLength(50),
                    async isUnique (value) {
                        if (value === '') return true
                        const response = await fetch(`/api/user/unique-username/${value}?api_token=${this.api_token}&id=${this.user_id}`)
                        return Boolean(await response.json())
                    }
                },
                email: {
                    email,
                    async isUnique (value) {
                        if (value === '') return true
                        const response = await fetch(`/api/user/unique-email/${value}?api_token=${this.api_token}&id=${this.user_id}`)
                        return Boolean(await response.json())
                    }
                },
                role: {
                    required
                },
                phonenumber: {
                },
                fonction: {}
            },
            password: {
                new: {
                    required
                },
                repeat: {
                    required,
                    sameAsPassword: sameAs('new')
                }
            }
        },
        created(){
            this.user.id = this.user_id
            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchUser()
            }
            this.csrfToken = document.querySelector('meta[name="csrf-token"]').content
        },

        methods: {
            fetchUser(page_url) {
                let vm = this;

                page_url = page_url || `/api/user/${this.user_id}?api_token=${this.api_token}`
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.user = res.data
                    })
                    .catch(error => console.log(error));
            },
            openModal(){
                this.$modal.show('reset-password', {
                    title: 'Rénitialisation du mot de passe!',
                });
            },
            closeModal(){
                this.$modal.hide('reset-password');
            },
            savePassword(){
                this.btnLoading = true
                let data = {
                    user: this.user.id,
                    password: this.password.new,
                }

                fetch(`/api/user/reset-password?api_token=${this.api_token}`, {
                    method: 'post',
                    body: JSON.stringify(data),
                    headers: {
                        'content-type': 'application/json'
                    }
                })
                    .then(res => res.json)
                    .then(data => {
                        this.btnLoading = false
                        this.$modal.hide('reset-password');
                        this.$toast.open({
                            message: "Mot de passe modifié!",
                            type: "success",
                            duration: 5000,
                            dismissible: true,
                            position: 'top-right'
                        })
                    })
                    .catch(error => {
                        this.btnLoading = false
                        this.$toast.open({
                            message: "Erreur modification du mot de passe!",
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
