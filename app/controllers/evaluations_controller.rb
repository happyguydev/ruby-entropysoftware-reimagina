class EvaluationsController < ApplicationController
  load_and_authorize_resource

  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu

  # GET /evaluations
  # GET /evaluations.json
  def index
    @evaluations = Evaluation.all

    respond_to do |format|
      format.html
      format.json { render json: EvaluationDatatable.new(view_context) }
    end
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
  end

  # GET /evaluations/new
  def new
    @evaluation = Evaluation.new
  
  end

  # GET /evaluations/1/edit
  def edit
  end

  # POST /evaluations
  # POST /evaluations.json
  def create

    @evaluation = Evaluation.new(evaluation_params)
    @evaluation.question_ids = params[:question_ids].uniq
    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to @evaluation, success: 'Evaluación creada con éxito.' }
        format.json { render :show, status: :created, location: @evaluation }
      else
        format.html { render :new }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evaluations/1
  # PATCH/PUT /evaluations/1.json
  def update
    respond_to do |format|
      if params[:question_ids] && !params[:question_ids].nil?
        @evaluation.question_ids = params[:question_ids].uniq
      else
        @evaluation.question_ids = []
      end
      if @evaluation.update(evaluation_params)
        format.html { redirect_to @evaluation, notice: 'Evaluación actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @evaluation }
      else
        format.html { render :edit }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: 'Evaluación borrada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def evaluation_params
    params.require(:evaluation).permit(:pdfguide,:nombre,:year, :evaluation_type_id, :assignature_id, :level_id, :question_attributes => [:id])
  end

  def set_admin_menu
    @admin_menu = true
  end
end
