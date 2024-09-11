class EvaluationsController < ApplicationController
    include ActionView::RecordIdentifier

    before_action :set_evaluation, only: [:show, :edit, :update, :destroy]
    before_action :set_project, only: [:new, :create]
    before_action :authenticate_user!
    before_action :authorize_evaluation, only: [:edit, :update, :destroy]
  
    # GET /evaluations
    def index
      @evaluations = Evaluation.all
      authorize @evaluations
    end
  
    # GET /evaluations/:id
    def show
      authorize @evaluation
    
      respond_to do |format|
        format.html # Rendre la vue show.html.erb
        format.turbo_stream # Gérer les requêtes Turbo Streams si nécessaire
      end
    end
    
  
    # GET /projects/:project_id/evaluations/new
    def new
      @evaluation = @project.evaluations.build
      authorize @evaluation
    end
  
    # POST /projects/:project_id/evaluations
    def create
      @evaluation = @project.evaluations.build(evaluation_params)
      @evaluation.evaluator = current_user
      
      if @evaluation.save
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.append('evaluation_list', partial: 'evaluations/evaluation', locals: { evaluation: @evaluation }) }
          format.html { redirect_to @project, notice: 'Évaluation créée avec succès.' }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end    
  
    # GET /evaluations/:id/edit
    def edit
    end
  
    # PATCH/PUT /evaluations/:id
    def update
      if @evaluation.update(evaluation_params)
        flash[:notice] = "Évaluation mise à jour avec succès."
        redirect_to @evaluation
      else
        flash[:alert] = "Erreur lors de la mise à jour de l'évaluation."
        render :edit
      end
    end
  
    # DELETE /evaluations/:id
    def destroy
      authorize @evaluation
      @evaluation.destroy
  
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@evaluation)) }
        format.html { redirect_to project_path(@evaluation.project), notice: "Évaluation supprimée avec succès." }
      end
    end
    
  
  
    private
  
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end
  
    def set_project
      @project = Project.find(params[:project_id])
    end
  
    def authorize_evaluation
      authorize @evaluation
    end
  
    def evaluation_params
      params.require(:evaluation).permit(:maturity_level, :feedback)
    end
  end
  