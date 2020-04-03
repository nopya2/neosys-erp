<template>
    <canvas id="lineChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
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

                page_url = page_url || `/api/engagements/ajax/engagements-par-annee?api_token=${this.api_token}`
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
                                    label               : 'Engagements',
                                    fill                : false,
                                    borderWidth         : 2,
                                    lineTension         : 0,
                                    spanGaps : true,
                                    borderColor         : '#0069D9',
                                    pointRadius         : 3,
                                    pointHoverRadius    : 7,
                                    pointColor          : '#0069D9',
                                    pointBackgroundColor: '#0069D9',
                                    data                : engagements
                                },
                                {
                                    label               : 'Payés',
                                    fill                : false,
                                    borderWidth         : 2,
                                    lineTension         : 0,
                                    spanGaps : true,
                                    borderColor         : '#009954',
                                    pointRadius         : 3,
                                    pointHoverRadius    : 7,
                                    pointColor          : '#009954',
                                    pointBackgroundColor: '#009954',
                                    data                : payes
                                },
                                {
                                    label               : 'Non Payés',
                                    fill                : false,
                                    borderWidth         : 2,
                                    lineTension         : 0,
                                    spanGaps : true,
                                    borderColor         : '#DC3545',
                                    pointRadius         : 3,
                                    pointHoverRadius    : 7,
                                    pointColor          : '#DC3545',
                                    pointBackgroundColor: '#DC3545',
                                    data                : non_payes
                                },
                            ]
                        }

                        var areaChartOptions = {
                            maintainAspectRatio : false,
                            responsive : true,
                            legend: {
                                display: true
                            },
                            scales: {
                                xAxes: [{
                                    gridLines : {
                                        display : true,
                                    }
                                }],
                                yAxes: [{
                                    gridLines : {
                                        display : true,
                                    }
                                }]
                            }
                        }

                        //-------------
                        //- LINE CHART -
                        //--------------
                        var lineChartCanvas = $('#lineChart').get(0).getContext('2d')
                        var lineChartOptions = jQuery.extend(true, {}, areaChartOptions)
                        var lineChartData = jQuery.extend(true, {}, areaChartData)
                        lineChartData.datasets[0].fill = false;
                        lineChartData.datasets[1].fill = false;
                        lineChartOptions.datasetFill = false

                        var lineChart = new Chart(lineChartCanvas, {
                            type: 'line',
                            data: lineChartData,
                            options: lineChartOptions
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
