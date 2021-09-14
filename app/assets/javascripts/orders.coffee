# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#orders-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#orders-table').data('source')
    paginType: 'full_numbers'
    language:
      url: "/Spanish.json"
    columns: [
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: false, searchable: false }
      ]

    dom : 'T<"clear">lfrtip'
    buttons: [{
            extend: 'copy',
            exportOptions: { columns: 'th:not(:last-child)'}
        },
        {
            extend: 'excel',
            exportOptions: { columns: 'th:not(:last-child)'}
        },
        {
            extend: 'pdf',
            exportOptions: { columns: 'th:not(:last-child)'}
        }
    ]

).yadcf [

    { column_number: 1, filter_type: 'select' }
]


  $('#collections-table').dataTable(
    processing: true
    serverSide: true
    ajax: $('#collections-table').data('source')
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
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: true }

      ]

    dom : 'T<"clear">lfrtip'


).yadcf [

    { column_number: 1, filter_type: 'select' }

]

  $('#facturas-table').dataTable(
      processing: true
      serverSide: true
      ajax: $('#facturas-table').data('source')
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
          { sortable: true,  searchable: true }
          { sortable: true,  searchable: true }
        ]

      dom : 'T<"clear">lfrtip'
      buttons: [{
              extend: 'copy',
              exportOptions: { columns: 'th:not(:last-child)'}
          },
          {
              extend: 'excel',
              exportOptions: { columns: 'th:not(:last-child)'}
          },
          {
              extend: 'pdf',
              exportOptions: { columns: 'th:not(:last-child)'}
          }
      ]

  ).yadcf [

      { column_number: 0, filter_type: 'select' }

  ]

  $('#historicos-table').dataTable(
      processing: true
      serverSide: true
      ajax: $('#historicos-table').data('source')
      paginType: 'full_numbers'
      language:
       url: "/Spanish.json"
      columns: [
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: true }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        { sortable: true,  searchable: false }
        ]

      dom : 'T<"clear">lfrtip'
      buttons: [{
              extend: 'copy',
              exportOptions: { columns: 'th:not(:last-child)'}
          },
          {
              extend: 'excel',
              exportOptions: { columns: 'th:not(:last-child)'}
          },
          {
              extend: 'pdf',
              exportOptions: { columns: 'th:not(:last-child)'}
          }
      ]

  ).yadcf [

      { column_number: 0, filter_type: 'select' }

  ]

  if $('#ingreso_orders').length > 0

    data_orders = [
      [
        "Formulario",
        "contrato",
        "Inicio Proceso",
        "Proceso",
        "Inscripción",
        "RBD",
        "N°",
        "Establecimiento",
        "Comuna",
        "Region",
        "Forma de Pago",
        "Rut Factura ",
        "Dependencia",
        "Evaluaciones",
        "e-mail",
        "Cargo",
        "Telefono",
        "Resultados",
        "e-mail",
        "Cargo",
        "Telefono",
        "Envio Factura",
        "Mail",
        "Telefono factura"
      ]
    ]

    ordersfirstRowRenderer = (instance, td, row, col, prop, value, cellProperties) ->
      Handsontable.renderers.TextRenderer.apply(this, arguments)
      td.style.fontWeight = 'bold'
      td.style.color = 'white'
      td.style.background = '#0070C0'

    ingreso_orders = document.getElementById('ingreso_orders')
    @mass_orders = new Handsontable ingreso_orders,
      data: data_orders,
      minSpareRows: 1,
      rowHeaders: false,
      colHeaders: false,
      contextMenu: true,
      cells: (row, col, prop) ->
        cellProperties = {}
        if row == 0
          cellProperties.renderer = ordersfirstRowRenderer
          cellProperties.readOnly = true
        return cellProperties

  $('#ord_mass_input').on 'click', (e) ->
    form_data = {
      mass_orders: mass_orders.getData()
    }
    $.ajax
      method: 'POST',
      data: { form_data: JSON.stringify(form_data)},
      url: "/orders/mass_input"
