# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#contents-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#contents-table').data('source')
    paginType: 'full_numbers'
    language: 
      url: "/Spanish.json"
    columns: [
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
]
    
    
#$ ->
#  $('#contents-table').dataTable
##    initComplete: addFilterContents
#    processing: true
#    serverSide: true
#    ajax: $('#contents-table').data('source')
#    paginType: 'full_numbers'
#    language:
#      url: "/assets/Spanish.json"
#    columns: [
#        { sortable: true,  searchable: true }
#        { sortable: true,  searchable: true }
#        { sortable: true,  searchable: true }
#        { sortable: false, searchable: false }
#      ]
    
#addFilterContents = ->
#  @api().columns().every ->
#    column = this
#    select = $('<select><option value=""></option></select>').appendTo($(column.footer()).empty()).on('change', ->
#      val = $.fn.dataTable.util.escapeRegex($(this).val())
#      column.search( val ? '^'+val+'$' : '', true, false ).draw()
#      return
#    )
#    column.data().unique().sort().each (d, j) ->
#      select.append '<option value="' + d + '">' + d + '</option>'
#      return
#    return
#  return