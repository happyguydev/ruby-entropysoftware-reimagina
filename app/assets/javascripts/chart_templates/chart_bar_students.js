var chartBarStudentsGenerator = function(config, data){

  $(config.container).highcharts({
    credits: {
      text: 'Reimagina',
      href: 'http://www.reimagina.cl'
    },
    chart: {
      type: 'bar',
      width: 999
    },
    title: {
      style: {
        fontSize:'25px'
      },
      text: config.title.text
    },
    subtitle: {
      style: {
        fontSize:'20px'
      },
      text: config.subtitle.text
    },
    xAxis: {
      categories: data.xAxis.categories,
      title: {
        text: null
      },
      labels: {
        style: {
          fontSize:'20px'
        }
      }
    },
    yAxis: {
      min: 0,
      max: 100,
      title: {
        text: 'Logro total %',
        align: 'high'
      },
      labels: {
        overflow: 'justify',
        style: {
          fontSize:'20px'
        }
      }
    },
    tooltip: {
      valueSuffix: ' %'
    },
    plotOptions: {
      bar: {
        dataLabels: {
          format: '{y}%',
          enabled: true
        }
      },
      series: {
        enableMouseTracking: false,
        shadow: false, 
        animation: false
      }
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'bottom',
      x: -40,
      y: 80,
      floating: true,
      borderWidth: 1,
      backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
      shadow: true
    },
    credits: {
      enabled: false
    },
    series: [{

      name: 'Logro',
      data: data.series.data
    }]
  });
};