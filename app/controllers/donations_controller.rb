class DonationsController < ApplicationController
	before_action :logged_in
	before_action :set_donation, only: [:show, :edit, :update, :destroy]  	
	before_action :set_project

	def new
	  @donation = Donation.new
	end

	def create
	  @donation = Donation.new
      # Amount in cents
      @donation.amount = 10
      @donation.project_id = @project.id
      @donation.alum_id = current_user.id
      @donation.save
      @project.donations << @donation
      
	  
	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @donation.amount * 100,
	    :description => 'AngelAlums Customer',
	    :currency    => 'usd'
	  )

	flash[:notice] = "Thanks, you paid $10.00!"
	redirect_to project_path(@project)

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to project_path(@project)
	end

	private
		def set_donation
	      @donation = Donation.find(params[:id])
	    end

		def set_project
	      @project = Project.find(params[:project_id])
	      # source: http://guides.rubyonrails.org/action_controller_overview.html#rescue
	      rescue ActiveRecord::RecordNotFound
	      redirect_to projects_path, notice: 'Cannot find specified project'
	    end

		# Never trust parameters from the scary internet, only allow the white list through.
	    def donation_params
	      params.require(:donation).permit(:amount)		            
	    end

	    def logged_in
	      if current_user == nil
	        redirect_to new_user_session_path
	      end
	    end
end
