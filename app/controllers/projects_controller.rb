class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in
  before_action :check_collab, only: [:edit, :update]
  before_action :check_owner, only: [:destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    #to allow forms to be built for multiple entries
    @project.taggables.build
    @project.advisors.build
    @project.collaborations.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.owner_id = @current_user.id
    respond_to do |format|
      if @project.save
        #add advisors, tags and collaborators
        @project.add_advisors(params[:project][:advisors_attributes])
        @project.add_tags(params[:project][:taggables_attributes])
        @project.add_collaborators(params[:project][:collaborations_attributes])
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params[:project].permit(:title, :image, :video, :description, :goal)
    end
    # check if current user is logged in
    def logged_in
      if current_user == nil
        redirect_to new_user_session_path
      end
    end
    #check if current user is a collaborator or owner fo project
    def check_collab
      set_project
      if @project.access_level(current_user.id) != "owner" && @project.access_level(current_user.id) != "collaborator"
        redirect_to projects_url
      end

    end
    #check if current user is an owner
    def check_owner
      set_project
      if @project.access_level(current_user) != "owner"
        redirect_to projects_url
      end

    end
end
