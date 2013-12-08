#This is the controller for Donation
class DonationsController < ApplicationController
	#Check if the user is logged in
	before_action :logged_in
	#Set the current donation
	before_action :set_donation, only: [:show, :edit, :update, :destroy]  	
	#Set the current project
	before_action :set_project
	#Check if the user is alum
	before_action :check_alum

	def new
	  @donation = Donation.new
	end

	def create
	  @donation = Donation.new
      # We will donate $10 for MVP, but will be able to change amount for the final
      @donation.amount = 10
      @donation.project_id = @project.id
      @donation.alum_id = current_user.id
      @donation.save
      @project.donations << @donation
      
      token = params[:stripeToken]

	  #Create a customer with the token created in the Stripe system
	  customer = Stripe::Customer.create(
	    :email => current_user.email,
	    :card  => params[:stripeToken]
	  )

	  #Charge the card with 1000 cents via the Stripe system
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
		#Set the current donation
		def set_donation
	      @donation = Donation.find(params[:id])
	    end

	    #Set the current project and if it cannot be found, redirect to projects_path with the notice
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

	    #Check whether current user is logged in
	    def logged_in
	      if current_user == nil
	        redirect_to new_user_session_path
	      end
	    end

	    #Check whether current user is alumni and if not, redirect to project page
	    def check_alum
	      if current_user.type != "Alumni"
	      	redirect_to project_path(@project)
	      end
	    end
end
