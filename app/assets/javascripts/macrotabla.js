function macrotablaTable(data){
  $(function() {
    var macrotablafirstRowRenderer, data_macrotabla, ingreso_macrotabla;
    if ($('#ingreso_macrotabla').length > 0) {
      data_macrotabla = data;
      macrotablafirstRowRenderer = function(instance, td, row, col, prop, value, cellProperties) {
        Handsontable.renderers.TextRenderer.apply(this, arguments);
        td.style.fontWeight = 'bold';
        td.style.color = 'white';
        return td.style.background = '#0070C0';
      };
      ingreso_macrotabla = document.getElementById('ingreso_macrotabla');
      this.mass_macrotabla = new Handsontable(ingreso_macrotabla, {
        data: data_macrotabla,
        width: 900,
        height: 550,
        minSpareRows: 1,
        rowHeaders: false,
        colHeaders: false,
        contextMenu: true,
        cells: function(r,c, prop) {
          var cellProperties = {};
          if(r===0) cellProperties.renderer = macrotablafirstRowRenderer;
          if (r ===0 ) cellProperties.readOnly = true;
          return cellProperties;
        }
      });
    }
    return $('#macrotabla_mass_input').on('click', function(e) {
      var form_data, evaluation;
      evaluation = "test"//$.parseJSON($(this).attr('data-evaluation'));
      form_data = {
          mass_macrotabla: mass_macrotabla.getData(),
          instrument: evaluation
      };
      return $.ajax({
        method: 'POST',
        data: {
          form_data: JSON.stringify(form_data)
        },
        url: "/learning_goals/macrotabla_submit",
        success: function(data){
          $('.flash').show();
          empty_values();
          }
      });
    });
  });
}
function empty_values(){
  var fields = []
  $.each( $('.htCore').find('td'),function(index,data){
    if (data.className.indexOf('htDimmed') != 0){
      fields.push(data)
    }
  });
  $.each( fields, function(index,field){
    field.textContent = ''
  });
}