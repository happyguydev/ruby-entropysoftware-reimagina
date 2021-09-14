$(function () {

    var colors = Highcharts.getOptions().colors,
        categories = ['Ciencias de la vida: Cuerpo humano', 'Ciencias de la vida', 'Ciencias de la tierra y el universo', 'Ciencias físicas y químicas'],
        data = [{
            y: 20,
            color: colors[0],
            drilldown: {
                name: 'Ciencias de la vida: Cuerpo humano',
                categories: ['Vida Saludable', 'Organos de los sentidos'],
                data: [10, 10],
                color: colors[0]
            }
        }, {
            y: 30,
            color: colors[1],
            drilldown: {
                name: 'Ciencias de la vida',
                categories: ['Seres vivos y no vivos', 'Alimentación de los seres vivos', 'Clasificación de los seres vivos', 'Desplazamiento de los seres vivos', 'Habitat', 'Las plantas', 'Clasificación de las semillas', 'Protección de la flora y fauna chilena','Estaciones del año','Los astros','Propiedades de los materiales','Caracteristicas de los materiales'],
                data: [2.5, 2.5, 2.5, 2.5, 2.5, 2.5,2.5, 2.5 ,2.5,2.5,2.5,2.5],
                color: colors[1]
            }
        }, {
            y: 15,
            color: colors[2],
            drilldown: {
                name: 'Ciencias de la tierra y el universo',
                categories: ['Estaciones del año', 'Los astros'],
                data: [7.5, 7.5],
                color: colors[2]
            }
        }, {
            y: 35,
            color: colors[3],
            drilldown: {
                name: 'Ciencias físicas y químicas',
                categories: ['Propiedades de los materiales', 'Caracteristicas de los materiales'],
                data: [30, 5],
                color: colors[3]
            }
        }, ],
        browserData = [],
        versionsData = [],
        i,
        j,
        dataLen = data.length,
        drillDataLen,
        brightness;


    // Build the data arrays
    for (i = 0; i < dataLen; i += 1) {

        // add browser data
        browserData.push({
            name: categories[i],
            y: data[i].y,
            color: data[i].color
        });

        // add version data
        drillDataLen = data[i].drilldown.data.length;
        for (j = 0; j < drillDataLen; j += 1) {
            brightness = 0.2 - (j / drillDataLen) / 5;
            versionsData.push({
                name: data[i].drilldown.categories[j],
                y: data[i].drilldown.data[j],
                color: Highcharts.Color(data[i].color).brighten(brightness).get()
            });
        }
    }

    // Create the chart
    $('#container').highcharts({
        chart: {
            type: 'pie'
        },
        title: {
            text: 'Cantidad de preguntas evaluación por contenidos de eje'
        },
        subtitle: {
            text: 'Porcentajes respecto al total de la evaluación'
        },
        yAxis: {
            title: {
                text: 'Total percent market share'
            }
        },
        plotOptions: {
            pie: {
                shadow: false,
                center: ['50%', '50%']
            }
        },
        tooltip: {
            valueSuffix: '%'
        },
        series: [{
            name: 'Preguntas eje',
            data: browserData,
            size: '70%',
            dataLabels: {
                formatter: function () {
                    return this.y > 5 ? this.point.name : null;
                },
                color: '#ffffff',
                distance: -30
            }
        }, {
            name: 'Preguntas contenido',
            data: versionsData,
            size: '80%',
            innerSize: '60%',
            dataLabels: {
                formatter: function () {
                    // display only if larger than 1
                    return this.y > 1 ? '<b>' + this.point.name + ':</b> ' + this.y + '%' : null;
                }
            }
        }]
    });
});