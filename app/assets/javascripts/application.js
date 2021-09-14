// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui/widgets/sortable
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/extras/dataTables.buttons
//= require chosen-jquery
//= require froala_editor.min.js
//= require plugins/font_size.min.js
//= require plugins/align.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require plugins/table.min.js
//= require languages/es.js
//= require cocoon
//= require holder
//= require scaffold
//= require growlyflash

//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require highcharts/modules/heatmap

//= require moment
//= require bootstrap-datetimepicker
//= require pickers
//= require moment/es
//= require twitter/bootstrap
//= require adminlte/app
//= require dataTables.responsive.min

//= require handsontable.full.min
//= require jquery.minicolors
//= require jquery.minicolors.simple_form
//= require jquery.bootstrap-growl.min
//= require jquery.rateyo.min.js

//= require dataTables.tableTools.min.js

//= require_tree .

function getFilterDate() {
  $("#filterDate").html("");
  $("#filterSchool").html("");
  $("#filterProccess").html("");
  var report_id = $("#report").val();
  if (report_id.length > 0) {
    $.ajax({
      url: "/comparatives/filter_date",
      type: "GET",
      dataType: "script",
      data: {
        report: report_id,
        format: "js"
      }
    });
  }
}

function getFilterSchool() {
  $("#filterSchool").html("");
  $("#filterProccess").html("");
  var report_id = $("#report").val();
  var ending_year = $("#ending_year").val();
  if (report_id.length > 0 && ending_year.length > 0) {
    $.ajax({
      url: "/comparatives/filter_school",
      type: "GET",
      dataType: "script",
      data: {
        report: report_id,
        year: ending_year,
        format: "js"
      }
    });
  }
}

function getFilterUser() {
  $("#filterSchool").html("");
  $("#filterProccess").html("");
  var report_id = $("#report").val();
  var ending_year = $("#ending_year").val();
  if (report_id.length > 0 && ending_year.length > 0) {
    $.ajax({
      url: "/comparatives/filter_user",
      type: "GET",
      dataType: "script",
      data: {
        report: report_id,
        year: ending_year,
        format: "js"
      }
    });
  }
}

function getFilterProccess() {
  $("#filterProccess").html("");
  var report_id = $("#report").val();
  var ending_year = $("#ending_year").val();
  var school_id = $("#school").val();
  var user_id = $("#user").val();
  if (
    report_id.length > 0 &&
    ending_year.length > 0 &&
    ((school_id != undefined && school_id.length > 0) ||
      (user_id != undefined && user_id.length > 0))
  ) {
    $.ajax({
      url: "/comparatives/filter_proccess",
      type: "GET",
      dataType: "script",
      data: {
        report: report_id,
        year: ending_year,
        school: school_id,
        user: user_id,
        format: "js"
      }
    });
  }
}
