<template>
    <form method="POST" action="/user">
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
                <input type="text" class="form-control" id="username" placeholder="Nom d'utilisateur" v-model.trim="$v.user.username.$model" name="username">
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
                <label for="password">Mot de passe <span class="text-danger">(*)</span></label>
                <input type="password" class="form-control" id="password" placeholder="" v-model.trim="$v.user.password.$model" name="password">
                <small class="form-text text-danger" v-if="!$v.user.password.required">Champs requis.</small>
                <small class="form-text text-danger" v-if="!$v.user.password.minLength">{{$v.user.password.$params.minLength.min}} caractères minimum.</small>
            </div>
            <div class="form-group col-md-6">
                <label for="repeat-password">Retapez le mot de passe</label>
                <input type="password" class="form-control" id="repeat-password" placeholder="" v-model.trim="$v.user.repeatPassword.$model">
                <small class="form-text text-danger" v-if="!$v.user.repeatPassword.sameAsPassword">Les mots de passe doivent etre identique.</small>
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
        <button type="submit" class="btn btn-success" :disabled="$v.user.$invalid">
            <i class="fa fa-save"></i> Créer
        </button>
    </form>

</template>

<script>
    import { required, minLength, maxLength, between, email, sameAs } from 'vuelidate/lib/validators';

    export default {
        mounted() {
            // console.log('Component mounted.')
        },

        props : [],

        data(){
            return{
                user: {
                    name: '',
                    firstname: '',
                    username: '',
                    email: '',
                    password: '',
                    repeatPassword: '',
                    role: "",
                    phonenumber: '',
                    status: true,
                    fonction: ''
                },
                spinner: false,
                csrfToken: null,
                api_token: '',

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
                        const response = await fetch(`/api/user/unique-username/${value}?api_token=${this.api_token}`)
                        return Boolean(await response.json())
                    }
                },
                email: {
                    email,
                    async isUnique (value) {
                        if (value === '') return true
                        const response = await fetch(`/api/user/unique-email/${value}?api_token=${this.api_token}`)
                        return Boolean(await response.json())
                    }
                },
                password: {
                    required,
                    minLength: minLength(8)
                },
                repeatPassword: {
                    sameAsPassword: sameAs('password')
                },
                role: {
                    required
                },
                phonenumber: {
                },
                fonction: {}
            }
        },
        mounted() {

        },
        created(){
            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token
            }

            this.csrfToken = document.querySelector('meta[name="csrf-token"]').content
        },

        methods: {

        }

    }
</script>
