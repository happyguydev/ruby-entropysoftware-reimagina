# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#axes_contents-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#axes_contents-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
