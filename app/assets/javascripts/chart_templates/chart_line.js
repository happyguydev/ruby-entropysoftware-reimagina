$(function () {
    $('#container').highcharts({

        credits: {
            text: 'Reimagina',
            href: 'http://www.reimagina.cl'
        },

        tooltip: {
            formatter: function () {
                return 'Pregunta ' + this.x + ' : ' + this.y + '% resp. correctas';
            }
        },

        plotOptions: {
            line: { /* or spline, area, series, areaspline etc.*/
                marker: {
                    enabled: false
                }
            }
        },
        title: {
            text: 'Promedio de logro por pregunta',
            x: -20 //center
        },
        subtitle: {
            text: 'Progreso del curso a lo largo de la prueba',
            x: -20
        },
        xAxis: {
            categories: ['1', '2', '3', '4', '5', '6',
                '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26',
                '27', '28', '29', '30', '31', '32', '33', '34', '35'],
            title: {
                text: 'N° de pregunta'
            },
        },
        yAxis: {

            max: 100,

            title: {
                text: 'Porcentaje de logro total'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },

        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: 'Logro total %',
            data: [98, 88, 79, 68, 64, 60, 60, 65, 55, 50, 50, 48, 45, 45, 40, 40, 38, 35, 39, 37, 20, 20, 22, 20, 19, 15, 14, 10, 11, 19]
        }]
    });
});