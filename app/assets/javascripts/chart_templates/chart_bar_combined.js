var chartBarCombinedGenerator = function(config, data){

  $(config.container).highcharts({
    tooltip: {
      formatter: function () {
        return this.y + '% resp. correctas';
      }
    },

    credits: {
      text: 'Reimagina',
      href: 'http://www.reimagina.cl'
    },
    chart: {
      type: 'bar'
    },
    title: {
      style: {
        fontSize:'25px'
      },
      text: '<b>'+config.title.text+'</b>'
    },

    subtitle: {
      style: {
        fontSize:'20px'
      },
      text: config.subtitle.text
    },
    xAxis: {
      valueSuffix: '%',
      categories: data.xAxis.categories,
      labels: {
        style: {
          fontSize:'20px'
        }
      }

    },
    yAxis: {
      labels: {
        format: '{value}%',
        style: {
          fontSize:'20px'
        }
      },
      min: 0,
      title: {
        text: 'Nivel de logro total'
      },
      min: 0,
      max: 100,

    },
    legend: {
      reversed: true
    },
    plotOptions: {
      series: {
        stacking: 'normal',
        enableMouseTracking: false,
        shadow: false, 
        animation: false
      }
    },
    series: data.series,
    dataLabels: {
      enabled: true,
      format: "{y}%"
    }
  });
};