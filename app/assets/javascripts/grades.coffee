# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#grades-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#grades-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
