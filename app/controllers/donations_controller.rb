class DonationsController < ApplicationController
	before_action :set_project

	def new
		@donation = Donation.new		
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
	  redirect_to project_path(@project)
	end

	private
		def set_project
	      @project = Project.find(params[:project_id])
	      # source: http://guides.rubyonrails.org/action_controller_overview.html#rescue
	      rescue ActiveRecord::RecordNotFound
	      redirect_to projects_path, notice: 'Cannot find specified project'
	    end
end
