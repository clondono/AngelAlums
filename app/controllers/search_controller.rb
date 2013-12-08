class SearchController < ApplicationController
  before_action :logged_in

  def index
      if params[:search]
          ids = params[:search][:tag_id].reject(&:empty?)
          @projects = Project.search(ids)
          @tags = Tag.find(ids)
      else
          @projects = []
          @tags = []
      end
  end

  private
  def logged_in
    if current_user == nil
      redirect_to new_user_session_path, alert: "You are not logged in"
    end
  end
end
