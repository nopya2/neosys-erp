
// require('./bootstrap');

window.Vue = require('vue');
import Vuelidate from 'vuelidate';
import VueContext from 'vue-context';
import Swatches from 'vue-swatches';
import VueFilterDateFormat from 'vue-filter-date-format';
import numeral from 'numeral';
import numFormat from 'vue-filter-number-format';
import { VuejsDatatableFactory } from 'vuejs-datatable';
import VueToast from 'vue-toast-notification';
// Import any of available themes
import 'vue-toast-notification/dist/theme-sugar.css';
import VModal from 'vue-js-modal'
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import CKEditor from '@ckeditor/ckeditor5-vue';
import vSelect from 'vue-select';

Vue.use(Vuelidate);
Vue.use(VueContext);
Vue.use(Swatches);
Vue.use(VueFilterDateFormat);
Vue.config.productionTip = false;
Vue.filter('numFormat', numFormat(numeral));
Vue.use( VuejsDatatableFactory );
Vue.use(VueToast);
Vue.use(VModal, {dynamic: true, injectModalsContainer: true})
Vue.use(VueSweetalert2);
Vue.use(require('vue-moment'));
Vue.use( CKEditor );

import  'vue-context/dist/css/vue-context.css';
import "vue-swatches/dist/vue-swatches.min.css"

require('./components/users/users');
require('./components/engagements/engagements');
require('./components/echelons/echelons');
require('./components/dashboard/dashboard');
require('./components/providers/providers');
require('./components/customers/customers');
require('./components/quotes/quotes');
require('./components/invoices/invoices');
require('./components/taxes/taxes');
require('./components/parameters/parameters');
require('./components/credit_notes/credit_notes');

Vue.component('example-component', require('./components/ExampleComponent.vue').default);
Vue.component('login-component', require('./components/LoginComponent.vue').default);
Vue.component('information-component', require('./components/InformationComponent.vue').default);
Vue.component('vue-context', require('vue-context').default);
Vue.component('swatches', require('vue-swatches').default);
Vue.component('v-select', vSelect);

import 'vue-select/dist/vue-select.css';

function updateFunction (el, binding) {
    // get options from binding value.
    // v-select="THIS-IS-THE-BINDING-VALUE"
    let options = binding.value || {};

    // set up select2
    $(el).select2(options).on("select2:select", (e) => {
        // v-model looks for
        //  - an event named "change"
        //  - a value with property path "$event.target.value"
        el.dispatchEvent(new Event('change', { target: e.target }));
    });
}
Vue.directive('select', {
    inserted: updateFunction ,
    componentUpdated: updateFunction,
});


const app = new Vue({
    components: {
        VueContext,
        Swatches,
        "vue-select": require("vue-select2"),
    },
    el: '#app',
});

// const login = new Vue({
//     el: '#login-page'
// });

// const header = new Vue({
//     el: '#header'
// })
