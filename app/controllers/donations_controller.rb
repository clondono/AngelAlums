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
	#Set the recipient of the donation before creating donations
	before_filter :set_recipient

	#Getting a new donation form
	def new
	  @donation = Donation.new
	end

	#Creating a new donation
	def create
	  @donation = Donation.new(donation_params)
	  #pulling donation amount
      @donation.amount = params[:donation_amount]
      @donation.project_id = @project.id
      @donation.alum_id = current_user.id
      @donation.save
      @project.donations << @donation
      
      #Getting a card token from the Stripe - any sensitive information does not touch server
      token = params[:stripeToken]

	  #Create a customer with the token created in the Stripe system
	  customer = Stripe::Customer.create(
	    :email => current_user.email,
	    :card  => params[:stripeToken]
	  )

	  #Charge the card with the specified amount via the Stripe system
	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @donation.amount * 100,
	    :description => @project.title,
	    :currency    => 'usd'
	  )

	  #Transfer the donation to the recipient who is the creator of the project
	  transfer = Stripe::Transfer.create(
		  :amount => @donation.amount * 100,
		  :currency => "usd",
		  :recipient => @recipient.id,
		  :statement_descriptor => "AlumnAngel Donation"
		)

	  #Give success message with the specified amount
	  flash[:notice] = "Thanks, you paid $%s!" % [@donation.amount]
	  redirect_to project_path(@project)

	  #If there is any errors while charing the card, give appropriate error messages
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

	    #Set the recipient of the donation by calling the bank information the creator put in when creating the project
	    def set_recipient
     		@recipient = @project.stripe_recipient
   		end

end
