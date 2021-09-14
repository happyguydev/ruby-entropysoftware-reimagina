# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#difficulty_levels-table').dataTable(
    #dom: 'T<"clear">lfrtip',
    #tableTools: 
        #"sSwfPath": "/assets/copy_csv_xls_pdf.swf"
    processing: true
    serverSide: true
    ajax: $('#difficulty_levels-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
    columns: [
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

).yadcf [
    
    { column_number: 0, filter_type: 'select' }  
 
]  
    
