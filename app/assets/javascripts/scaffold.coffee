$ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    search_contains: true
    no_results_text: 'No hay resultados en la busqueda'
    placeholder_text_single: "Seleccione una opcion",
    placeholder_text_multiple: "Seleccione opciones"
    width: '200px'