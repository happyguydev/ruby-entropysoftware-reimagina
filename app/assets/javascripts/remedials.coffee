# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#remedials-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#remedials-table').data('source')
    paginType: 'full_numbers'
    language: 
      url: "/Spanish.json"
    columns: [
      { sortable: true, searchable: true }
      { sortable: true, searchable: true }
      { sortable: true, searchable: true }
      { sortable: true, searchable: true }
      { sortable: false, searchable: false}
    ]

    dom : 'T<"clear">lfrtip'
    buttons: [{
            extend: 'copy',
            exportOptions: { columns: 'th:not(:last-child)'}
        },
        {
            extend: 'excel',
            exportOptions: { columns: 'th:not(:last-child)'}
        },
        {
            extend: 'pdf',
            exportOptions: { columns: 'th:not(:last-child)'}
        }
    ]

).yadcf [
    
    { column_number: 1, filter_type: 'select' }
    { column_number: 2, filter_type: 'select' }
    { column_number: 3, filter_type: 'select' }
    
]

      # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No hay resultados'
    width: '200px'
    
    
  $('#assignature_content').on 'change', (e)->
    loadContents(this.value)
    
  loadContents = (id)->
    $('#school_commune_id').html ""
    $.ajax('/communes_by_region/'+id)
    .done (data, status)->
      data.forEach (c)->
        opt = document.createElement('option')
        opt.value = c[1]
        opt.innerHTML = c[0]
        $('#rem_commune_id').append opt


  $('.remedial_select').chosen().change (e) ->
    assignature = $('#assignature').val()
    content = $('#remedial_content_id').val()
    $.ajax
      method: 'post'
      data:
        assignature: assignature
        content: content
      url: '/remedials/get_content'
