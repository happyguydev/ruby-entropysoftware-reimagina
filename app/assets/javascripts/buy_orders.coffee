# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#buy-orders-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#buy-orders-table').data('source')
    paginType: 'full_numbers'
    responsive: true
    language:
      url: "/Spanish.json"
