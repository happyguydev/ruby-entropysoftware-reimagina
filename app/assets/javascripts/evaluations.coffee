jQuery ->
  $('#evaluations-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#evaluations-table').data('source')
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
    { column_number: 3, filter_type: 'select' }
    { column_number: 4, filter_type: 'select' }


]

  $('#questions-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#questions-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
      columns: [
        { sortable: false, searchable: false }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }
        { sortable: true, searchable: true }

      ]).yadcf [

    { column_number: 2, filter_type: 'select'}
    { column_number: 3, filter_type: 'select'}
    { column_number: 4, filter_type: 'select'}
    { column_number: 5, filter_type: 'select'}
    { column_number: 6, filter_type: 'select'}
    { column_number: 7, filter_type: 'select'}
    { column_number: 8, filter_type: 'select'}
    { column_number: 9, filter_type: 'select'}
    { column_number: 10, filter_type: 'select'}
    { column_number: 11, filter_type: 'select'}
  ]

  $('#questions-table').on 'draw.dt', ->
    $('.add-question-button').on 'click', (e) ->
      e.preventDefault()
      check_if_question_exists this, ($this)->
        parentRow = $this.parent().parent()
        parentRowBtn = parentRow.find('button')
        parentRowHtml = parentRow.html()
        $("#addQuestionsBody tr").each (index, row) ->
          addQuestionBtn = $(row).find('button')
          return true if (parentRow.find('td:last').text() != $(row).find('td:last').text())
          return true if (parentRow.find('td:last').text() == '' && parentRowBtn.data('id') != addQuestionBtn.data('id'))
          parentTr = document.createElement('tr')
          removeTd = document.createElement('td')
          removeTdHtml = '<button name="button" ' +
          'onclick="this.parentNode.parentNode.remove();" ' +
          'type="button" class="btn btn-danger remove-question-button">' +
          '<i class="fa fa-times"></i></button>'
          $(removeTd).html(removeTdHtml)
          textTd = document.createElement('td')
          $(textTd).html(addQuestionBtn.data('texto'))
          assignatureTd = document.createElement('td')
          $(assignatureTd).html(addQuestionBtn.data('assignature'))
          levelTd = document.createElement('td')
          $(levelTd).html(addQuestionBtn.data('level'))
          unitTd = document.createElement('td')
          $(unitTd).html(addQuestionBtn.data('unit'))
          hidden_input = document.createElement('input')
          hidden_input.type = 'hidden'
          hidden_input.name = 'question_ids[]'
          hidden_input.value = addQuestionBtn.data('id')
          parentTr.appendChild removeTd
          parentTr.appendChild textTd
          parentTr.appendChild assignatureTd
          parentTr.appendChild levelTd
          parentTr.appendChild unitTd
          parentTr.appendChild hidden_input
          $('#questions-table-body').append parentTr

  check_if_question_exists = ($this, callback) ->
    $this = $($this)
    exists = false
    $('#questions-table-body > tr > input[type=hidden]').each (n, e) ->
      if e.value.toString() == $this.data('id').toString()
        exists = true
    .promise()
    .done ->
      if !exists
        callback($this)
