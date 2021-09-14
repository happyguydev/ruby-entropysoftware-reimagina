function remedialsTable(data){
  $(function() {
    var remedialsfirstRowRenderer, data_remedials, ingreso_remedials;
    if ($('#ingreso_remedials').length > 0) {
      data_remedials = data;
      answersfirstRowRenderer = function(instance, td, row, col, prop, value, cellProperties) {
        Handsontable.renderers.TextRenderer.apply(this, arguments);
        td.style.fontWeight = 'bold';
        td.style.color = 'white';
        return td.style.background = '#0070C0';
      };
      ingreso_remedials = document.getElementById('ingreso_remedials');
      this.mass_remedials = new Handsontable(ingreso_remedials, {
        data: data_remedials,
        width: 900,
        height: 550,
        minSpareRows: 1,
        rowHeaders: false,
        colHeaders: false,
        contextMenu: true,
        cells: function(r,c, prop) {
          var cellProperties = {};
          if(r===0) cellProperties.renderer = remedialsfirstRowRenderer;
          if (c===0 || c===1 || r ===0) cellProperties.readOnly = true;
          return cellProperties;
        }
      });
    }
    return $('#rem_mass_input').on('click', function(e) {
      var form_data, evaluation;
      evaluation = $.parseJSON($(this).attr('data-evaluation'));
      form_data = {
          mass_remedials: mass_remedials.getData(),
          instrument: evaluation
      };
      return $.ajax({
        method: 'POST',
        data: {
          form_data: JSON.stringify(form_data)
        },
        url: "/advices/mass_remedials",
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