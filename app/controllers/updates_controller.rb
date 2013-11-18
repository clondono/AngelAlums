class UpdatesController < ApplicationController
  before_action :set_update, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index, :new, :show, :destroy]
  before_action :can_write?, only: [:index, :new]
  before_action :can_edit?, only: [:index, :show, :edit, :destroy]
  before_action :authenticate

  # GET /updates
  # GET /updates.json
  def index
    @updates = Update.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.json { render :json => @posts }
      format.atom
    end
  end

  # GET /updates/1
  # GET /updates/1.json
  def show
    #update = Update.find(params[:id])
    #@project = update.project
  end

  # GET /updates/new
  def new
    if @can_write == false
      redirect_to root_url
      return
    end
    @update = Update.new
  end

  # GET /updates/1/edit
  def edit
  end

  # POST /updates
  # POST /updates.json
  def create
    @update = Update.new(update_params)
    @update.project_id = params[:project_id]
    respond_to do |format|
      if @update.save
        format.html { redirect_to @update, notice: 'Update was successfully created.' }
        format.json { render action: 'show', status: :created, location: @update }
      else
        format.html { render action: 'new' }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /updates/1
  # PATCH/PUT /updates/1.json
  def update
    respond_to do |format|
      if @update.update(update_params)
        format.html { redirect_to @update, notice: 'Update was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.json
  def destroy
    @update.destroy
    respond_to do |format|
      format.html { redirect_to project_updates_path(@project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_update
      @update = Update.find(params[:id])
    end

    def can_write?
      if current_user == @project.student
        @can_write = true
      else
        @can_write = false
      end
    end

    def can_edit?
      return true
    end

    
    def set_project
	  if params[:project_id]
        @project = Project.find(params[:project_id])
      else
        @project = Update.find(params[:id]).project
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      params.require(:update).permit(:title, :content, :image, :project_id, :user_id)
    end
    
    def authenticate
    end
end
