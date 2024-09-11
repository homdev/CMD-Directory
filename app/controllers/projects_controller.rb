class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_member]
  before_action :authenticate_user!
  before_action :authorize_project, only: [:edit, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all
    authorize @projects
  end

  # GET /projects/:id
  def show
    authorize @project
    @evaluation = Evaluation.new # Initialiser une nouvelle évaluation
    authorize @evaluation, :create? # Autoriser la création
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
    authorize @project
  end

  # POST /projects
  def create
    Rails.logger.debug "Current user: #{current_user.inspect}"
    @project = current_user.projects.build(project_params)
    @project.project_leader = current_user # Définir le porteur de projet
    authorize @project
  
    if @project.save
      # Ajouter automatiquement le créateur comme membre du projet avec le rôle de leader
      ProjectMember.create(project: @project, user: current_user, role: 'leader')

      respond_to do |format|
        format.html { redirect_to @project, notice: 'Project successfully created.' }
        format.turbo_stream { render turbo_stream: turbo_stream.append('project_list', partial: 'projects/project', locals: { project: @project }) }
      end
    else
      Rails.logger.debug(@project.errors.full_messages) # Ajout pour déboguer
      render :new, status: :unprocessable_entity
    end
  end

  # GET /projects/:id/edit
  def edit
  end

  # PATCH/PUT /projects/:id
  def update
    if @project.update(project_params)
      flash[:notice] = "Project successfully updated."
      redirect_to @project
    else
      flash[:alert] = "Error updating project."
      render :edit
    end
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    flash[:notice] = "Project successfully deleted."
    redirect_to projects_path
  end

  # POST /projects/:id/add_member
  def add_member
    user = User.find(params[:user_id])
    role = params[:role]

    if @project.members.include?(user)
      redirect_to @project, alert: 'User is already a member of the project.'
    else
      ProjectMember.create(project: @project, user: user, role: role)
      redirect_to @project, notice: 'Member added successfully.'
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_project
    authorize @project
  end

  def project_params
    params.require(:project).permit(:name, :description, :sector, :funding_needed, :start_date, :end_date, :progress, :opportunities)
  end
end
