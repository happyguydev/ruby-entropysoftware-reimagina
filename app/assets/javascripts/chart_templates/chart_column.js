var chartColumnGenerator = function(config, data){

    $(config.container).highcharts({
        
        tooltip: {
            formatter: function () {
                return this.x + ' : ' + this.y + '%';
            }
        },
        credits: {
            text: 'Reimagina',
            href: 'http://www.reimagina.cl'
        },
        chart: {
            type: 'column',
            margin: 75
        },
        title: {
            text: '<b>'+config.title.text+'</b>'
        },
        subtitle: {
            text: '<i>'+config.subtitle.text+'</i>'
        },
        plotOptions: {
            column: {
                depth: 25,
                colorByPoint: true
            }
        },
        colors: [
            '#779ECB',
            '#C23B22',
            '#03C03C',
            '#B19CD9'],
        xAxis: {
            categories: data.labels
        },
        yAxis: {

            labels: {
                format: '{value}%'
            },

            title: {
                text: null
            },
            min: 0,
            max: 100,
            tickInterval: 10


        },
        series: [{

            dataLabels: {
                enabled: true,
                format: "{y}%"
            },
            showInLegend: false,
            data: data.series.data
        }]
    });
};



















