# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#invoices-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#invoices-table').data('source')
    paginType: 'full_numbers'
    responsive: true
    language:
      url: "/Spanish.json"
      