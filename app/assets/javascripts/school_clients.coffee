# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#school-billing-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#school-billing-table').data('source')
    paginType: 'full_numbers'
    
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: false,  searchable: false }
      ]

$ ->
  $('#school-invoices-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#school-invoices-table').data('source')
    paginType: 'full_numbers'
    
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: false, searchable: false }
      ]

$ ->
  $('#school-feedback-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#school-feedback-table').data('source')
    paginType: 'full_numbers'
    
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: false, searchable: false }
      ]

$ ->
  $('#school-evaluations-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#school-evaluations-table').data('source')
    paginType: 'full_numbers'
    
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: false, searchable: false }
      ]).yadcf [

      { column_number: 0, filter_type: 'select'}
      { column_number: 1, filter_type: 'select' }
      { column_number: 2, filter_type: 'select'}
      { column_number: 3, filter_type: 'select' }
      { column_number: 4, filter_type: 'select' }
]

$ ->
  $('#school-result_n_report-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#school-result_n_report-table').data('source')
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
        { sortable: false, searchable: false }
      ]).yadcf [

      { column_number: 0, filter_type: 'select'}
      { column_number: 1, filter_type: 'select' }
      { column_number: 2, filter_type: 'select'}
      { column_number: 3, filter_type: 'select' }
      { column_number: 4, filter_type: 'select' }
      { column_number: 5, filter_type: 'select' }

]