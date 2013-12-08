# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Stripe.setPublishableKey("pk_test_eZfnT3GTTvsfV42aAbSMPxC3")

$(document).on 'submit', '#new_donation', ->  
  $form = $("#new_donation")
  # Disable the submit button to prevent repeated clicks
  $("#new_donation :submit").prop("disabled", true)
  Stripe.card.createToken($form, stripeResponseHandler)
  # Prevent the form from submitting with the default action
  false

stripeResponseHandler = (status, response) ->
  $form = $("#new_donation")

  if response.error
    # Show the errors on the form
    $("#new_donation .error_messages").text response.error.message
    $("#new_donation :submit").prop("disabled", false)
  else
    # token contains id, last4, and card type
    token = response.id
    
    # Insert the token into the form so it gets submitted to the server
    $form.append $("<input type=\"hidden\" name=\"stripeToken\" />").val(token)

    # and submit
    $form.get(0).submit()