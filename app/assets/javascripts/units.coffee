# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#units-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#units-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
    columns: [
      { sortable: true, searchable: true }
      { sortable: true, searchable: true }
      { sortable: true, searchable: true }
      { sortable: true, searchable: true }
      { sortable: false, searchable: false}
    ]
    dom : 'T<"clear">lfrtip'
    buttons: [{
            extend: 'copy',
            exportOptions: { columns: 'th:not(:last-child)'} 
            text: 'Copiar'         },
          {
              extend: 'excel',
              exportOptions: { columns: 'th:not(:last-child)'}
          },
          {
              extend: 'pdf',
              exportOptions: { columns: [4]}
          }
      ]).yadcf [
    
    { column_number: 0, filter_type: 'select' }
    { column_number: 1, filter_type: 'select' }
    { column_number: 2, filter_type: 'select' }
    
 ]
    
  $('.change_goals').chosen().change (e) ->
    assignature = $('#unit_assignature_id').val()
    nivel = $('#unit_level_id').val()
    $.ajax
      method: 'post'
      data:
        assignature: assignature
        nivel: nivel
      url: '/units/get_learning_goals'

    
  add_assignature_options = (data) ->
    data.learning_goals.forEach (learning_goal) ->
      $('#unit_learning_goal_ids').append('<option value="'+learning_goal[0]+'">'+learning_goal[1]+'</option>')
    $('#unit_learning_goal_ids').trigger 'chosen:updated'

    