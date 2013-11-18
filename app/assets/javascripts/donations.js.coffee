# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$('#stripe-button-el').click ->
  		$('#stripe-button').attr('data-amount', $('#donation_amount').val()*100)

$(document).ready(ready)
$(document).on('page:load', ready)