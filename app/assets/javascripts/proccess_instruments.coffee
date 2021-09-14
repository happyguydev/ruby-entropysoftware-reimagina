# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#proccess_instruments-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#proccess_instruments-table').data('source')
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

      ]).yadcf [

    { column_number: 1, filter_type: 'select' }
    { column_number: 2, filter_type: 'select' }
    { column_number: 4, filter_type: 'select' }
    { column_number: 5, filter_type: 'select' }
    { column_number: 6, filter_type: 'select' }




]
  $('#proccess_instrument_admin-table').dataTable(
    processing: true
    serverSide: true
    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Todos los"]]
    ajax: $('#proccess_instrument_admin-table').data('source')
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
        { sortable: false,  searchable: false }
        { sortable: true,  searchable: true }


      ]).yadcf [

    { column_number: 0, filter_type: 'select' }
    { column_number: 1, filter_type: 'select' }
    { column_number: 2, filter_type: 'select' }
    { column_number: 3, filter_type: 'select' }
    { column_number: 4, filter_type: 'select' }
    { column_number: 5, filter_type: 'select' }
    { column_number: 7, filter_type: 'select' }



]
