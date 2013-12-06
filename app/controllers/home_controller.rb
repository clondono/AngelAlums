class HomeController < ApplicationController
  
  #dashboard for future work ( not mvp)

  def index

  	@projects = current_user.projects

  end
  
end
