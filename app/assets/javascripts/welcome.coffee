# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('.remove-question-button').click (e) ->
		console.log 'remove question'
		$(this).closest('tr').remove()
$(document).ready ->
  $('body').prepend '<div id="overlay" class="ui-widget-overlay" style="z-index: 1031; display: none;"></div>'
  $('#overlay').append '<div id=\'please-wait\' style=\'display: none;\'>Cargando...</div>'
$(document).on 'click', '#ans_mass_input', ->
  $('#overlay, #please-wait').show()
  return
