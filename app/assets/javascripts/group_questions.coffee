$ ->
  paragraph = $('.box-body').find("p:contains('[PREGUNTAS]')")
  paragraph.text () -> 
    $(this).text().replace('[PREGUNTAS]', '[preguntas van aquí]')

  $('#group_questions-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#group_questions-table').data('source')
    paginType: 'full_numbers'
    responsive: true
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true } 
        { sortable: false, searchable: false }
        { sortable: false, searchable: false }
      ])