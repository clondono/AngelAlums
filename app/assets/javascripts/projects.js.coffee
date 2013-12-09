# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$(".tag-select").select2({placeholder: "Select at least one Tag"})
	$('#carousel-main').carousel({interval: 6000})
	$('#carousel-mine').carousel({interval: 6000})
	$('#carousel-collab').carousel({interval: 6000})
	$('#carousel-donate').carousel({interval: 6000})

$(document).ready(ready)
$(document).on('page:load', ready)

Stripe.setPublishableKey("pk_test_eZfnT3GTTvsfV42aAbSMPxC3")

$(document).on 'submit', '#new_project', ->  
  # Disable the submit button to prevent repeated clicks
  $("#new_project :submit").prop("disabled", true)
  Stripe.bankAccount.createToken({
    country: "US",
    routingNumber: $('#routing_number').val(),
    accountNumber: $('#account_number').val(),
  }, stripeResponseHandler)
  # Prevent the form from submitting with the default action
  false
stripeResponseHandler = (status, response) ->
  $form = $("#new_project")

  if response.error
    # Show the errors on the form
    console.log(response.error.message)
    $("#new_project .account_error_messages").text response.error.message
    $("#new_project :submit").prop("disabled", false)
  
  else
    
    # token contains id, last4, and card type
    token = response.id
    
    # Insert the token into the form so it gets submitted to the server
    $form.append $("<input type=\"hidden\" name=\"stripeToken\" />").val(token)
    
    # and submit
    $form.get(0).submit()