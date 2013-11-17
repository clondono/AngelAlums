class DonationsController < ApplicationController
	def new
	end

	def create
	  # Amount in cents
	  @amount = 1000

	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'AngelAlums Customer',
	    :currency    => 'usd'
	  )

	redirect_to project_path(@project)

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to donation_path
	end
end
