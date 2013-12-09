class HomeController < ApplicationController
  before_action :logged_in
  #dashboard for future work ( not mvp)

  def index
    @highlighted_projects = Project.where(:highlighted => true)
    @all_projects = Project.all
    if current_user.type == "Student"
      @my_projects = current_user.projects
      @collab_projects = current_user.shared_projects
    else
      @donated_projects = current_user.projects.uniq_by(&:id)
    end
  end



  private
  def logged_in
    if current_user == nil
      redirect_to new_user_session_path
    end
  end
  
end
