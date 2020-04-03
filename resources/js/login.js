
// require('./bootstrap');

window.Vue = require('vue');
import Vuelidate from 'vuelidate';

Vue.use(Vuelidate);
Vue.config.productionTip = false;

// require('./components/users/users');

// Vue.component('example-component', require('./components/ExampleComponent.vue').default);
Vue.component('login-component', require('./components/LoginComponent.vue').default);


const login = new Vue({
    el: '#login-page'
});

// const header = new Vue({
//     el: '#header'
// })
