# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$(".search-select").select2({placeholder: "Search Projects by Tags"})

$(document).ready(ready)
$(document).on('page:load', ready)