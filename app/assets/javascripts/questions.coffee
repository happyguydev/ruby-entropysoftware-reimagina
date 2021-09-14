# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.rich-text-area-question').froalaEditor
    toolbarButtons: ['fullscreen', 'bold', 'italic', 'underline', 'fontFamily', 'fontSize', 'color', 'paragraphStyle', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', 'insertHR', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'insertTable', 'undo', 'redo', 'clearFormatting','subscript','superscript']
    placeholderText: 'Ingrese texto pregunta'
    language: 'es'
    key: 'FwcnehmbblD6lA-8=='
    imageUploadToS3:
      bucket: $("body").data('bucket')
      region: 's3'
      keyStart: $("body").data('key-start')
      callback: (url, key) ->
        console.log url
        console.log key
      params:
        acl: $("body").data('acl')
        AWSAccessKeyId: $("body").data('access-key')
        policy: $("body").data('policy')
        signature: $("body").data('signature')
    imageManagerLoadURL: '/upload_gallery.json'
  $('.rich-text-area-question').on 'froalaEditor.image.inserted', (e, editor, $img, response) ->
    key = $(response).find('key').text()
    $('#froalaImageTags').find('input[name="froala_image[key]"]').val(key)
    $('#froalaImageTags').modal()


  $('#question_assignature_id').chosen().change (e) ->
    $.ajax
      datatype: 'json',
      method: 'POST',
      data: {assignature_id: $(this).val()},
      url: '/questions/get_assignature_dependants',
      success: (data) ->

        $('#question_unit_id').html("")
        $('#question_content_id').html("")
        $('#question_axis_id').html("")
        $('#question_axis_program_id').html("")
        $('#question_pme_ability_id').html("")
        $('#question_assignature_ability_id').html("")
        $('#question_learning_goal_id').html("")
        $('#question_learning_goal_id').trigger 'chosen:updated'
        $('#question_unit_id').html("")
        $('#question_unit_id').trigger 'chosen:updated'
        $('#question_level_id').attr("disabled", false)
        $('#question_level_id').val('').trigger 'chosen:updated'
        add_assignature_options data


  add_assignature_options = (data) ->
    data.contents.forEach (content) ->
      $('#question_content_id').append('<option value="'+content[0]+'">'+content[1]+'</option>')
    data.axes.forEach (axis) ->
      $('#question_axis_id').append('<option value="'+axis[0]+'">'+axis[1]+'</option>')
    data.pme_abilities.forEach (ability) ->
      $('#question_pme_ability_id').append('<option value="'+ability[0]+'">'+ability[1]+'</option>')
    data.assignature_abilities.forEach (ability) ->
      $('#question_assignature_ability_id').append('<option value="'+ability[0]+'">'+ability[1]+'</option>')
    data.axis_programs.forEach (axis) ->
      $('#question_axis_program_id').append('<option value="'+axis[0]+'">'+axis[1]+'</option>')
    $('#question_content_id').trigger 'chosen:updated'
    $('#question_pme_ability_id').trigger 'chosen:updated'
    $('#question_axis_id').trigger 'chosen:updated'
    $('#question_assignature_ability_id').trigger 'chosen:updated'
    $('#question_axis_program_id').trigger 'chosen:updated'




  $('#question_level_id').chosen().change (e) ->
    $.ajax
      datatype: 'json',
      method: 'POST',
      data: {assignature_id: $('#question_assignature_id').val(), level_id: $(this).val()},
      url: '/questions/get_level_dependants',
      success: (data) ->
        $('#question_learning_goal_id').html("")
        $('#question_learning_goal_id').trigger 'chosen:updated'
        $('#question_unit_id').html("")
        $('#question_learning_goal_id').attr("disabled", false)
        $('#question_unit_id').attr("disabled", false)
        $('#question_axis_id').attr("disabled", false)
        $('#question_axis_id').trigger 'chosen:updated'
        $('#question_content_id').attr("disabled", false)
        $('#question_content_id').trigger 'chosen:updated'
        $('#question_axis_program_id').attr("disabled", false)
        $('#question_axis_program_id').trigger 'chosen:updated'
        $('#question_pme_ability_id').attr("disabled", false)
        $('#question_pme_ability_id').trigger 'chosen:updated'
        $('#question_assignature_ability_id').attr("disabled", false)
        $('#question_assignature_ability_id').trigger 'chosen:updated'
        learning_goal_options data


  learning_goal_options = (data) ->
    data.learning_goals.forEach (learning_goal) ->
      $('#question_learning_goal_id').append('<option value="'+learning_goal[0]+'">'+learning_goal[1]+'</option>')
      $('#question_learning_goal_id').trigger 'change'
      $('#question_learning_goal_id').trigger 'chosen:updated'


  $('#questions-list-table').dataTable(
    processing: true
    serverSide: true
    responsive: false
    ajax: $('#questions-list-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
      columns: [
        { sortable: false, searchable: false }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: false }

      ]).yadcf [

      { column_number: 1, filter_type: 'select'}
      { column_number: 2, filter_type: 'select' }
      { column_number: 3, filter_type: 'select'}
      { column_number: 4, filter_type: 'select' }
      { column_number: 5, filter_type: 'select' }
      { column_number: 6, filter_type: 'select' }
      { column_number: 7, filter_type: 'select' }
      { column_number: 8, filter_type: 'select' }
      { column_number: 9, filter_type: 'select' }
      { column_number: 10, filter_type: 'select' }
      { column_number: 11, filter_type: 'select' }
]

@mq_pauta
$ ->

  if $('#ingreso_especificaciones').length > 0

    data_pauta = [
      [
          "REACTIVO",
          "CLAVE",
          "CONTENIDO",
          "EJE EN PROGRAMA",
          "EJE APRENDIZAJE",
          "HABILIDAD/INDICADOR PME",
          "AE - OA - OF",
          "N° DE AE - OA - OF",
          "UNIDAD",
          "HABILIDAD PROPIA DE LA ASIGNATURA",
          "HABILIDAD COGNITIVA",
          "NIVEL DE DIFICULTAD",
          "REMEDIALES",
          "CURSO PREGUNTA"
      ]
    ]

    pautafirstRowRenderer = (instance, td, row, col, prop, value, cellProperties) ->
      Handsontable.renderers.TextRenderer.apply(this, arguments)
      td.style.fontWeight = 'bold'
      td.style.color = 'white'
      td.style.background = '#0070C0'

    ingreso_questions = document.getElementById('ingreso_especificaciones')
    @mq_pauta = new Handsontable ingreso_questions,
      data: data_pauta,
      width: 900,
      height: 320,
      minSpareRows: 1,
      rowHeaders: false,
      colHeaders: false,
      contextMenu: true,
      cells: (row, col, prop) ->
        cellProperties = {}
        if row == 0
          cellProperties.renderer = pautafirstRowRenderer
          cellProperties.readOnly = true
        return cellProperties

  $('#mq_bt').on 'click', (e) ->
    $('#overlay, #please-wait').show()
    form_data = {
      mass_mq:   mq_pauta.getData(),
      evaluation_name: $('#evaluation_name').val(),
      evaluation_type: $('#evaluation_type').val(),
      evaluation_year: $('#evaluation_year').val(),
      assignature_id: $('#assignature_id').val(),
      alternatives_amount: $('#alternatives_amount').val(),
      level_id: $('#level_id').val()
    }

    if $('#evaluation_name').val().length < 1
      $('.validate-evaluation_name').html '<span style="color:red;"> Ingrese nombre de la evaluacion.</span>'
      $('#overlay, #please-wait').hide();
    else
      $.ajax
        method: 'POST',
        data: { form_data: JSON.stringify(form_data)},
        url: "/questions/mass_input_create"
