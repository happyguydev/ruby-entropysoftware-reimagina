# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateQueryStringParameter = (uri, key, value) ->
  re = new RegExp("([?&])" + key + "=.*?(&|$)", "i")
  separator = (if uri.indexOf("?") isnt -1 then "&" else "?")
  if uri.match(re)
    uri.replace re, "$1" + key + "=" + value + "$2"
  else
    uri + separator + key + "=" + value

$(document).ready ->
  $(".chosen-select").chosen();
  $(".chosen-container").attr "style", "width: 100%;"

