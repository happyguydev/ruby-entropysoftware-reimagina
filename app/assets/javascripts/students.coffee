# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@mass_students

$ ->
  $('#students-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#students-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"

  if $('#ingreso_students').length > 0

    data_students = [
      [
        "RUT",
        "NOMBRES",
        "APELLIDOS"
      ]
    ]

    studentsfirstRowRenderer = (instance, td, row, col, prop, value, cellProperties) ->
      Handsontable.renderers.TextRenderer.apply(this, arguments)
      td.style.fontWeight = 'bold'
      td.style.color = 'white'
      td.style.background = '#0070C0'

    ingreso_students = document.getElementById('ingreso_students')
    @mass_students = new Handsontable ingreso_students,
      data: data_students,
      width: 300,
      height: 320,
      minSpareRows: 1,
      rowHeaders: false,
      colHeaders: false,
      contextMenu: true,
      cells: (row, col, prop) ->
        cellProperties = {}
        if row == 0
          cellProperties.renderer = studentsfirstRowRenderer
          cellProperties.readOnly = true
        return cellProperties

  $("#stu_mass_input").on "click", (e) ->
    grade = $.parseJSON($(this).attr("data-grade"))
    form_data =
      mass_students: mass_students.getData()
      grade: grade

    $.ajax
      method: "POST"
      data:
        form_data: JSON.stringify(form_data)

      url: "/students/mass_input"
      success: (data) ->
        $('.flash').show();
      error: (textStatus, errorThrown) ->
        $('.error').show();
