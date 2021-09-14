var chartHeatMapGenerator = function(config, data){

  $(config.container).highcharts({
    credits: {
      text: 'Reimagina',
      href: 'http://www.reimagina.cl'
    },

    chart: {
      type: 'heatmap',
      marginTop: 40,
      marginBottom: 50,
      plotBorderWidth: 1

    },


    title: {
      text: null

    },

    xAxis: {

      categories: data.xAxis.categories,
      opposite: true,
      labels: {
        style: {
          fontSize:'13px'
        }
      }

    },

    yAxis: {
      reversed: true,
      categories: data.yAxis.categories,
      title: null,
      labels: {
        style: {
          fontSize:'15px'
        }
      }
    },

    colorAxis: {

      labels: {
        format: '{value}%',
        style: {
          fontSize:'20px'
        }

      },
      reversed: false,
      min: 0,
      max: 100,
      tickInterval: 10,
      stops: data.colorAxis.stops 
    },
    legend: {
      enabled: false,
      align: 'right',
      layout: 'vertical',
      margin: 0,
      verticalAlign: 'top',
      y: 25,
      symbolHeight: 280
    },

    tooltip: {
      formatter: function () {
        return '<b>' + this.series.yAxis.categories[this.point.y] + '</b> logró <br><b>' + this.point.value + '</b>% en <br><b>' + this.series.xAxis.categories[this.point.x] + '</b>';
      }
    },

    series: [{
      name: 'Logro por alumno por eje',
      borderWidth: 1,
      data: data.series.data,
      dataLabels: {
        style: {
          fontSize:'20px'
        },
        formatter: function() {
                    		if(this.point.value > 100){
                        	return this.point.value
                        }
                        else{
                        return this.point.value+'%'
                        }
                    },
        enabled: true,
        color: 'black',
        style: {
          textShadow: false
        }

      }
    }]

  });
}; 