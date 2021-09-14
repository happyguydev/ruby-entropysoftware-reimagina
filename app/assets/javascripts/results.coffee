@pauta
@respuestas
@reporte_pdf = ""
$ ->
  
  if $('#ingreso_pauta').length > 0
  
    data_pauta = [
      [
        "REACTIVO", 
        "CLAVE", 
        "CONTENIDO", 
        "HABILIDAD PME", 
        "EJE", 
        "OBJETIVO DE APRENDIZAJE", 
        "OA NÚMERO"
      ]
    ]

    pautafirstRowRenderer = (instance, td, row, col, prop, value, cellProperties) ->
      Handsontable.renderers.TextRenderer.apply(this, arguments)
      td.style.fontWeight = 'bold'
      td.style.color = 'white'
      td.style.background = '#0070C0'

    ingreso_pauta = document.getElementById('ingreso_pauta')
    @pauta = new Handsontable ingreso_pauta,
      data: data_pauta,
      minSpareRows: 1,
      rowHeaders: false,
      colHeaders: false,
      contextMenu: true,
      cells: (row, col, prop) ->
        cellProperties = {}
        if row == 0
          cellProperties.renderer = pautafirstRowRenderer
          cellProperties.readOnly = false
        return cellProperties
    
    
    
    data_respuestas = [
      [
        "Alumno", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15",
        "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", 
        "32", "33", "34", "35", "36", "37", "38", "39", "40"
      ]

    ]
    ingreso_respuestas = document.getElementById('ingreso_respuestas');  
    @respuestas = new Handsontable ingreso_respuestas,
      data: data_respuestas,
      minSpareRows: 1,
      rowHeaders: false,
      colHeaders: false,
      contextMenu: true,
      cells: (row, col, prop) ->
        cellProperties = {}
        if row == 0
          cellProperties.renderer = pautafirstRowRenderer
          if col != 1 or col != 2
            cellProperties.readOnly = true
        return cellProperties

      
  $('#generar_informe_btn').on 'click', (e) ->
    form_data = { 
      pauta: pauta.getData(), 
      respuestas: respuestas.getData(),
      nombre_instrumento: $('#nombre_instrumento').val(),
      nombre_colegio: $('#nombre_colegio').val(),
      asignatura: $('#asignatura').val(),
      curso: $('#curso').val()
    }
    $.ajax
      datatype: 'json',
      method: 'POST',
      data: { form_data: JSON.stringify(form_data)},
      url: '/results/mass_input_post_data',
      success: (data) ->
        console.log data
        $('.modal-body').html data
        $('.modal').modal 'show'
        
  $('#generar_informe_pdf_btn').on 'click', (e) ->
    form_data = { 
      pauta: pauta.getData(), 
      respuestas: respuestas.getData(),
      nombre_instrumento: $('#nombre_instrumento').val(),
      nombre_colegio: $('#nombre_colegio').val(),
      asignatura: $('#asignatura').val(),
      curso: $('#curso').val()
    }
    $.ajax
      datatype: 'application/pdf',
      method: 'POST',
      data: { form_data: JSON.stringify(form_data)},
      url: '/results/mass_input_pdf',
      success: (data) ->
#        pdf = new Blob([data]);
#        a = document.createElement('a')
#        a.href = URL.createObjectURL(pdf)
#        a.download = 'reporte-sick.pdf'
#        a.click()
        window.location = data.url
