# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#ranges-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#ranges-table').data('source')
    paginType: 'full_numbers'
    responsive: true
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: false, searchable: false }
        { sortable: false, searchable: false }
      ]).yadcf [
    
    { column_number: 0, filter_type: 'select' }
    { column_number: 1, filter_type: 'select' }
    { column_number: 2, filter_type: 'select' }
    { column_number: 3, filter_type: 'select' }
    { column_number: 4, filter_type: 'select' }
    { column_number: 5, filter_type: 'select' }
    
]