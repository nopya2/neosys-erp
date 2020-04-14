import Vue from 'vue'
import VueSweetalert2 from 'vue-sweetalert2';

Vue.use(VueSweetalert2);

export const Functions = {
    showAlert: function(position, icon, title) {
        // alert(position)
        Vue.swal({
            position: position,
            icon: icon,
            title: title,
            showConfirmButton: false,
            timer: 5000,
            toast: true
        });

    }
};