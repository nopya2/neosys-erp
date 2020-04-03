<template>
    <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
</template>

<script>
    export default {
        mounted() {

        },

        props : [],

        data(){
            return{
                spinner: false,
                data: {}
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

                page_url = page_url || `/api/engagements/ajax/montants-par-annee?api_token=${this.api_token}`
                fetch(page_url)
                    .then(res => res.json())
                    .then(res => {
                        this.spinner = false
                        let labels = res.years
                        let engagements = res.engagements
                        let payes = res.payes
                        let non_payes = res.non_payes

                        var areaChartData = {
                            labels  : labels,
                            datasets: [
                                {
                                    label               : 'Total engages',
                                    backgroundColor     : '#0069D9',
                                    borderColor         : '#0069D9',
                                    pointRadius          : false,
                                    pointColor          : '#0069D9',
                                    pointStrokeColor    : '#0069D9',
                                    pointHighlightFill  : '#fff',
                                    pointHighlightStroke: '#0069D9',
                                    data                : engagements
                                },
                                {
                                    label               : 'Total payes',
                                    backgroundColor     : '#009954',
                                    borderColor         : '#009954',
                                    pointRadius         : false,
                                    pointColor          : '#009954',
                                    pointStrokeColor    : '#009954',
                                    pointHighlightFill  : '#009954',
                                    pointHighlightStroke: '#009954',
                                    data                : payes
                                },
                                {
                                    label               : 'Total non payes',
                                    backgroundColor     : '#DC3545',
                                    borderColor         : '#DC3545',
                                    pointRadius         : false,
                                    pointColor          : '#DC3545',
                                    pointStrokeColor    : '#DC3545',
                                    pointHighlightFill  : '#DC3545',
                                    pointHighlightStroke: '#DC3545',
                                    data                : non_payes
                                },
                            ]
                        }


                        //-------------
                        //- BAR CHART -
                        //-------------
                        var barChartCanvas = $('#barChart').get(0).getContext('2d')
                        var barChartData = jQuery.extend(true, {}, areaChartData)
                        var temp0 = areaChartData.datasets[0]
                        var temp1 = areaChartData.datasets[1]
                        barChartData.datasets[0] = temp1
                        barChartData.datasets[1] = temp0

                        var barChartOptions = {
                            responsive              : true,
                            maintainAspectRatio     : false,
                            datasetFill             : false
                        }

                        var barChart = new Chart(barChartCanvas, {
                            type: 'bar',
                            data: barChartData,
                            options: barChartOptions
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
