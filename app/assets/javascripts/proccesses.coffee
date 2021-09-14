# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#proccesses-table').DataTable
    processing: true
    serverSide: true
    ajax: $('#proccesses-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: false,  searchable: false }
        { sortable: false,  searchable: false }
      ]

  $('#process_intruments_by_order').dataTable(
    processing: true
    serverSide: true
    ajax: $('#process_intruments_by_order').data('source')
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


      ]).yadcf [

    { column_number: 1, filter_type: 'select' }
    { column_number: 2, filter_type: 'select' }
    { column_number: 3, filter_type: 'select' }
    { column_number: 4, filter_type: 'select' }
    { column_number: 5, filter_type: 'select' }


]

  $('#process_intruments_by_order').on 'draw.dt', ->
    $('.btn-add-instrument').on 'click', (e)->
      $.get(window.location.pathname + "/add_instrument/" + $(this).data('id'))
      .done (data, status, xhr) ->
        $('#proccess_instruments-table').DataTable().ajax.reload()
      .fail (data, status, xhr) ->
        console.log('error')

  $('#proccess_instruments-table').on 'draw.dt', ->
    $('.btn-remove-instrument').on 'click', (e)->
      $.get(window.location.pathname + "/remove_instrument/" + $(this).data('id'))
      .done (data, status, xhr) ->
        $('#proccess_instruments-table').DataTable().ajax.reload()
      .fail (data, status, xhr) ->
        console.log('error')
