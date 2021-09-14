# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#assignature_abilities-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#assignature_abilities-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: false, searchable: false }
      ]