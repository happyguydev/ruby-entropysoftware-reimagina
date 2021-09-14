var chartBarContentsGenerator = function(config, data) {
  $(config.container).highcharts({
    credits: {
      text: "Reimagina",
      href: "http://www.reimagina.cl"
    },
    chart: {
      type: "bar",
      height: data.series.data.length * 40 + 300
    },

    plotOptions: {
      bar: {
        dataLabels: {
          style: {
            fontSize: "20px"
          },
          format: "{y}%",
          enabled: true
        }
      },
      series: {
        enableMouseTracking: false,
        shadow: false,
        animation: false
      }
    },
    tooltip: {
      formatter: function() {
        return (
          "<b>" +
          this.series.xAxis.categories[this.point.x] +
          "</b> : " +
          this.point.y +
          "%"
        );
      }
    },

    title: {
      style: {
        fontSize: "25px"
      },
      text: "<b>" + config.title.text + "</b>"
    },
    xAxis: {
      valueSuffix: "%",
      categories: data.labels,
      labels: {
        style: {
          fontSize: "20px"
        }
      }
    },
    yAxis: {
      labels: {
        format: "{value}%",
        style: {
          fontSize: "20px"
        }
      },

      title: {
        text: null
      },
      min: 0,
      max: 100,
      tickInterval: 10
    },
    series: [
      {
        dataLabels: {
          enabled: true,
          format: "{y}%"
        },
        showInLegend: false,
        data: data.series.data
      }
    ]
  });
};
