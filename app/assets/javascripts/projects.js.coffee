# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
	$(".tag-select").select2({placeholder: "Select at least one Tag"})
	$('#carousel-example-generic').carousel()

$(document).ready(ready)
$(document).on('page:load', ready)