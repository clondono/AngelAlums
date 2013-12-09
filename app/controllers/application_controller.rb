class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :update_sanitized_params, if: :devise_controller?
  # Use different layouts for homepage and other pages
  layout :layout_by_resource

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name,:type)
    devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name, :major, :grad_year, :avatar, :facebook, :hangout)
  end

  #render layout "devise" on the homepage while rendering layout "application" for other pages
  def layout_by_resource
    if devise_controller? && resource_name == :user && (action_name == 'new' || action_name == 'create')
      "devise"
    else
      "application"
    end
  end

end
