var chartBarGenerator = function(config, data){

  $(config.container).highcharts({

    chart: {
      type: 'bar'
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
      categories: data.labels,

    },
    yAxis: {
      min: 0,
      title: {
        text: config.yAxis.title.text
      },
      min: 0,
      max: 100,

    },
    legend: {
      reversed: true
    },
    series: data.series,
  });
};

// Input de ejemplo pal gustavito ito ito :D.

//chartBarGenerator({ 
//  container: "#chart_container", 
//  title: { text: "p1n3s" }, 
//  subtitle: { text: "pines2" }, 
//  yAxis: { 
//    title: { 
//      text: "sickeiro" 
//    } 
//  } 
//}, { 
//  labels: ['Ciencias de la vida', 'Ciencias de la vida: Cuerpo Humano y Salud', 'Ciencias Físicas y Químicas', 'Ciencias de la tierra y el universo']
//  , series: [
//    {
//      dataLabels: {
//        format: '{y}%',
//        enabled: true,
//        align: 'right',
//        color: '#FFFFFF',
//        x: -10
//      },
//      name: '81% - 100% - Alto',
//      data: [50, 35, 10, 0],
//      color: 'green'
//    }, 
//    {
//      dataLabels: {
//        format: '{y}%',
//        enabled: true,
//        align: 'right',
//        color: '#FFFFFF',
//        x: -10
//      },
//      name: '61% - 80% - Medio alto',
//      data: [15, 35, 10, 0],
//      color: 'yellow'
//    }, 
//    {
//      dataLabels: {
//        format: '{y}%',        
//        enabled: true,
//        align: 'right',
//        color: '#FFFFFF',
//        x: -10
//      },
//      name: '51% - 60% - Medio Bajo',
//      data: [15, 20, 50, 50],
//      color: 'orange'
//    },      
//    {
//      dataLabels: {
//        format: '{y}%',
//        enabled: true,
//        align: 'right',
//        color: '#FFFFFF',
//        x: -10
//      },
//      name: '0% - 50% - Bajo',
//      data: [20, 10,30, 50],
//      color: 'red'
//    }
//  ]
//});