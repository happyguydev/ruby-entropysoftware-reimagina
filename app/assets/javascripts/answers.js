function answerTable(data){
  $(function() {
    var answersfirstRowRenderer, data_answers, ingreso_answers;
    if ($('#ingreso_answers').length > 0) {
      data_answers = data;
      answersfirstRowRenderer = function(instance, td, row, col, prop, value, cellProperties) {
        Handsontable.renderers.TextRenderer.apply(this, arguments);
        td.style.fontWeight = 'bold';
        td.style.color = 'white';
        return td.style.background = '#0070C0';
      };
      ingreso_answers = document.getElementById('ingreso_answers');
      this.mass_answers = new Handsontable(ingreso_answers, {
        data: data_answers,
        width: 900,
        height: 550,
        minSpareRows: 1,
        rowHeaders: false,
        colHeaders: false,
        contextMenu: true,
        cells: function(r,c, prop) {
          var cellProperties = {};
          if(r===0) cellProperties.renderer = answersfirstRowRenderer;
          if (c===0 || c===1 || c===2 || r ===0) cellProperties.readOnly = true;
          return cellProperties;
        }
      });
    }
    return $('#ans_mass_input').on('click', function(e) {
      var form_data, proccess_instrument_id;
      proccess_instrument_id = $.parseJSON($(this).attr('data-proccess_instrument_id'));
      send_mail_status = $('#send_mail_status').is(':checked'),
      form_data = {
          mass_answers: mass_answers.getData(),
          send_mail_status: send_mail_status,
          proccess_instrument_id: proccess_instrument_id
      };
      return $.ajax({
        method: 'POST',
        data: {
          form_data: JSON.stringify(form_data)
        },
        url: "/answers/mass_input",
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
