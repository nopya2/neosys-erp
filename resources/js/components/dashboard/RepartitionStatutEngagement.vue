<template>
    <div class="col-md-12">
        <div class="d-flex justify-content-center mb-3" v-if="spinner">
            <div class="spinner-grow text-warning" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <canvas id="donutChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 764px;" width="764" height="250" class="chartjs-render-monitor"></canvas>
    </div>
</template>

<script>


    export default {
        mounted() {

        },

        props : ['n_engage'],

        data(){
            return{
                spinner: false,
                data: {
                    engagement_paye: 0,
                    engagement_non_paye: 0
                }
            }
        },

        created(){

            if (window.localStorage.getItem('authUser')) {
                const authUser = JSON.parse(window.localStorage.getItem('authUser'))
                this.api_token = authUser.api_token

                this.fetchData()
            }
        },

        methods: {
            fetchData(page_url) {
                let vm = this;
                this.spinner = true;

                page_url = page_url || `/api/engagements/ajax/engagements-par-statut?api_token=${this.api_token}`
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        this.data.engagement_paye = res.engagement_paye
                        this.data.engagement_non_paye = res.engagement_non_paye

                        var donutChartCanvas = $('#donutChart').get(0).getContext('2d')
                        var donutData        = {
                            labels: [
                                'Engagement payé',
                                'Engagement non payé',
                            ],
                            datasets: [
                                {
                                    data: [ this.data.engagement_paye,this.data.engagement_non_paye],
                                    backgroundColor : ['#00a65a', '#f56954'],
                                }
                            ]
                        }
                        var donutOptions     = {
                            maintainAspectRatio : false,
                            responsive : true,
                        }
                        //Create pie or douhnut chart
                        // You can switch between pie and douhnut using the method below.
                        var donutChart = new Chart(donutChartCanvas, {
                            type: 'doughnut',
                            data: donutData,
                            options: donutOptions
                        })

                    })
                    .catch(error => {
                        toastr.error('Erreur chargement des données!.')
                        this.spinner = false
                    });
            },
        }

    }
</script>
