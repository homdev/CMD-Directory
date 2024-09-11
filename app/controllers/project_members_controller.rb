class ProjectMembersController < ApplicationController
    before_action :set_project
    before_action :set_project_member, only: [:edit, :update, :destroy]
  
    # GET /projects/:project_id/project_members/new
    def new
      @project_member = @project.project_members.new
    end
  
    # POST /projects/:project_id/project_members
    def create
      @project_member = @project.project_members.new(project_member_params)
      if @project_member.save
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.append('project_members_list', partial: 'project_members/project_member', locals: { project_member: @project_member }) }
          format.html { redirect_to project_path(@project), notice: 'Membre ajouté avec succès.' }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    # GET /projects/:project_id/project_members/:id/edit
    def edit
    end
  
    # PATCH/PUT /projects/:project_id/project_members/:id
    def update
      if @project_member.update(project_member_params)
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace(@project_member, partial: 'project_members/project_member', locals: { project_member: @project_member }) }
          format.html { redirect_to project_path(@project), notice: 'Membre mis à jour avec succès.' }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # DELETE /projects/:project_id/project_members/:id
    def destroy
      @project_member.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@project_member) }
        format.html { redirect_to project_path(@project), notice: 'Membre supprimé avec succès.' }
      end
    end
  
    private
  
    def set_project
      @project = Project.find(params[:project_id])
    end
  
    def set_project_member
      @project_member = @project.project_members.find(params[:id])
    end
  
    def project_member_params
      params.require(:project_member).permit(:user_id, :role)
    end
  end
  