class UserStepsController < ApplicationController
  include Wicked::Wizard
  steps :personal, :contact
  
  #created wizard for first time login
  def show
    @user = current_user
    render_wizard
  end

  #updates the params for wizard
  def update
    @user = current_user
    @user.attributes = params[:user]
    render_wizard @user
  end
  
  def edit
  end
end
