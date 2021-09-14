# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#feedbacks-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#feedbacks-table').data('source')
    paginType: 'full_numbers'
    responsive: true
    language: 
      url: "/Spanish.json"
    columns: [
      { sortable: true, searchable: true }
      { sortable: true, searchable: true }
      { sortable: true, searchable: true }
      { sortable: false, searchable: false }
      { sortable: false, searchable: false }
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

).yadcf [
    
    { column_number: 0, filter_type: 'select' }    
    { column_number: 1, filter_type: 'select' } 
]