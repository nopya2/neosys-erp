<template>
    <form method="POST" action="/customer">
        <input type="hidden" :value="csrfToken" name="_token"/>
        <div class="form-row">
            <!--<div class="form-group col-md-6">-->
                <!--<label for="customer_number">Numéro du client <span class="text-danger">(*)</span></label>-->
                <!--<input type="text" class="form-control" id="customer_number" placeholder="" v-model.trim="$v.customer.customer_number.$model"-->
                   <!--name="customer_number" readonly>-->
            <!--</div>-->
            <div class="form-group col-md-6">
                <label for="company_name">Nom de l'entreprise <span class="text-danger">(*)</span></label>
                <input type="text" class="form-control" id="company_name" placeholder="Nom de l'entreprise" v-model="$v.customer.company_name.$model" name="company_name">
                <small class="form-text text-danger" v-if="!$v.customer.company_name.required">Champs requis.</small>
                <small class="form-text text-danger" v-if="!$v.customer.company_name.minLength">{{$v.customer.company_name.$params.minLength.min}} caractères minimum.</small>
                <small class="form-text text-danger" v-if="!$v.customer.company_name.maxLength">{{$v.customer.company_name.$params.maxLength.max}} caractères maximum.</small>
                <small class="form-text text-danger" v-if="!$v.customer.company_name.isUnique">Cet nom est déjà utilisé</small>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="phonenumber">Numéro de téléphone <span class="text-danger">(*)</span></label>
                <input type="text" class="form-control" id="phonenumber" placeholder="" v-model="$v.customer.phonenumber.$model" name="phonenumber">
                <small class="form-text text-danger" v-if="!$v.customer.phonenumber.required">Champs requis.</small>
            </div>
            <div class="form-group col-md-6">
                <label for="email">E-mail <span class="text-danger">(*)</span></label>
                <input type="email" class="form-control" id="email" placeholder="E-mail" v-model="$v.customer.email.$model" name="email">
                <small class="form-text text-danger" v-if="!$v.customer.email.email">E-mail invalide.</small>
                <small class="form-text text-danger" v-if="!$v.customer.email.isUnique">Cet email est déjà utilisé</small>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="country">Pays <span class="text-danger">(*)</span></label>
                <select id="country" class="form-control" v-model="$v.customer.country.$model" name="country">
                    <option value="">--- Sélectionnez un pays ---</option>
                    <option v-for="country in countries" v-bind:value="country">{{ country }}</option>
                </select>
                <!--<small class="form-text text-danger" v-if="!$v.customer.country.required">Champs requis.</small>-->
                <!--<vue-select class="vue-select1" name="select1" :options="countries" :model.sync="customer.country">-->
                <!--</vue-select>-->
            </div>
            <div class="form-group col-md-6">
                <label for="city">Ville <span class="text-danger">(*)</span></label>
                <select id="city" class="form-control" v-model="$v.customer.city.$model" name="city">
                    <option value="">--- Sélectionnez une ville ---</option>
                    <option v-for="city in cities" v-bind:value="city">{{ city }}</option>
                </select>
                <small class="form-text text-danger" v-if="!$v.customer.city.required">Champs requis.</small>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="activity">Activité <span class="text-danger">(*)</span></label>
                <select id="activity" class="form-control" v-model="$v.customer.activity.$model" name="activity">
                    <option value="">--- Sélectionnez une activité ---</option>
                    <option v-for="activity in activities" v-bind:value="activity">{{ activity }}</option>
                </select>
                <small class="form-text text-danger" v-if="!$v.customer.activity.required">Champs requis.</small>
            </div>
            <div class="form-group col-md-6">
                <label for="address">Adresse <span class="text-danger">(*)</span></label>
                <textarea id="address" class="form-control" v-model="$v.customer.address.$model" name="address"></textarea>
                <small class="form-text text-danger" v-if="!$v.customer.address.required">Champs requis.</small>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="bp">Boite postale</label>
                <input type="text" class="form-control" id="bp" placeholder="" v-model="$v.customer.bp.$model" name="bp">
            </div>
            <div class="form-group col-md-6">
                <label for="website">Site web</label>
                <input type="text" class="form-control" id="website" placeholder="" v-model="$v.customer.website.$model" name="website">
            </div>
        </div>
        <button type="submit" class="btn btn-success" :disabled="$v.customer.$invalid">
            <i class="feather icon-check-circle"></i>Créer
        </button>
    </form>

</template>

<script>
    import { required, minLength, maxLength, between, email, sameAs } from 'vuelidate/lib/validators'
    import { countries } from '../data/countries'
    import { cities } from '../data/cities'
    import { activities } from '../data/activities'

    export default {

        data(){
            return{
                customer: {
                    // manager_id: '',
                    // customer_number: '',
                    company_name: '',
                    phonenumber: '',
                    email: '',
                    address: '',
                    website: '',
                    bp: "",
                    country: 'Gabon',
                    city: 'Libreville',
                    activity: ''
                },
                countries: countries,
                cities: cities,
                activities: activities,
                spinner: false,
                csrfToken: null,
                api_token: ''

            }
        },
        validations: {
            customer: {
                // customer_number: {
                //     required
                // },
                company_name: {
                    required,
                    minLength: minLength(3),
                    maxLength: maxLength(255),
                    async isUnique (value) {
                        if (value === '') return true
                        const response = await fetch(`/api/customer/unique-name/${value}?api_token=${this.api_token}`)
                        return Boolean(await response.json())
                    }
                },
                phonenumber: {
                    required,
                },
                email: {
                    required,
                    email,
                    async isUnique (value) {
                        if (value === '') return true
                        const response = await fetch(`/api/customer/unique-email/${value}?api_token=${this.api_token}`)
                        return Boolean(await response.json())
                    }
                },
                address: {
                    required,
                    minLength: minLength(3)
                },
                website: {
                },
                bp: {
                    // required
                },
                country: {
                    required
                },
                city: {
                    required
                },
                activity: {
                    required
                }
            }
        },
        mounted() {
            $("#country").select2({placeholder:"Sélectionnez un pays"})
            $("#city").select2({placeholder:"Sélectionnez une ville"})
        },
        created(){
            if (window.localStorage.getItem('authUser')) {
                const authCustomer = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authCustomer.api_token

                this.getCustomerNumber()
            }

            this.csrfToken = document.querySelector('meta[name="csrf-token"]').content
        },

        methods: {
            getCustomerNumber(page_url) {
                page_url = page_url || `/api/customer/generate-customer-number?api_token=${this.api_token}`
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.customer.customer_number = parseInt(res)
                    })
                    .catch(error => {

                    });
            },
        }

    }
</script>
