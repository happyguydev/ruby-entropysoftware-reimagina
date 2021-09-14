# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#learning_goals-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#learning_goals-table').data('source')
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

    { column_number: 0, filter_type: 'select' }
    { column_number: 1, filter_type: 'select' }
    { column_number: 2, filter_type: 'select' }

]

  $('.change_units').chosen().change (e) ->
    assignature = $('#learning_goal_assignature_id').val()
    nivel = $('#learning_goal_level_id').val()
    $.ajax
      method: 'post'
      data:
        assignature: assignature
        nivel: nivel
      url: '/learning_goals/get_units'


  add_assignature_options = (data) ->
    data.units.forEach (unit) ->
      $('#learning_goal_unit_ids').append('<option value="'+unit[0]+'">'+unit[1]+'</option>')
    $('#learning_goal_unit_ids').trigger 'chosen:updated'
  
 $('.cucu').bind 'cocoon:after-insert', (e, newContent) ->
   alert ":) I received it"
   newContent.find('.chosen-select').chosen()