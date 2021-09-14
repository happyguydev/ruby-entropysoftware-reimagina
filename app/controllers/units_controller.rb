class UnitsController < ApplicationController
  load_and_authorize_resource

  before_action :set_unit, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu
  # GET /units
  # GET /units.json
  def index
    @unit = Unit.new
    @units = Unit.all

    respond_to do |format|
      format.html
      format.json { render json: UnitDatatable.new(view_context) }
    end
  end

  # GET /units/1
  # GET /units/1.json
  def show
  end

  # GET /units/new
  def new
    @unit = Unit.new
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to units_path, notice: 'Unidad creada con éxito.' }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to units_path, notice: 'Unidad actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessablle_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to units_url, notice: 'Unidad borrada con éxito.' }
      format.json { head :no_content }
    end
  end

  def get_assignature_dependants
    assignature = Assignature.find(params[:assignature_id]) || Assignature.first
    level = Level.find(params[:level_id]) || Level.first
    learning_goals = LearningGoal.all.where(assignature_id: assignature ,level_id: level).map{|c| [c.id, c.numero]}
    res = { learning_goals: learning_goals}
    render json: res
  end

  def get_learning_goals
    @learning_goals = LearningGoal.where(assignature_id: params[:assignature], level_id: params[:nivel]).collect{|goal| [goal.nombre,goal.id]}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_unit
    @unit = Unit.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def unit_params
    params.require(:unit).permit(:assignature_id, :level_id, :numero, :descripcion, :learning_goal_ids => [])
  end

  def set_admin_menu
    @admin_menu = true
  end
end
