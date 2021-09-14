# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#schools-table').dataTable
    processing: true
    serverSide: true
    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Todos los"]]
    ajax: $('#schools-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: false, searchable: false }
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
      # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No hay resultados'
    width: '200px'
    
    
  $('#school_region').on 'change', (e)->
    loadCommunes(this.value)
    
  loadCommunes = (id)->
    $('#school_commune_id').html ""
    $.ajax('/communes_by_region/'+id)
    .done (data, status)->
      data.forEach (c)->
        opt = document.createElement('option')
        opt.value = c[1]
        opt.innerHTML = c[0]
        $('#school_commune_id').append opt