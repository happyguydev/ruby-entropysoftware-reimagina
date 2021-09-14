class DifficultyLevelsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_difficulty_level, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu

  # GET /difficulty_levels
  # GET /difficulty_levels.json
  def index
    @difficulty_levels = DifficultyLevel.all
    @difficulty_level = DifficultyLevel.new
    respond_to do |format|
      format.html
      format.json { render json: DifficultyLevelDatatable.new(view_context) }
    end
  end

  # GET /difficulty_levels/1
  # GET /difficulty_levels/1.json
  def show
  end

  # GET /difficulty_levels/new
  def new
    @difficulty_level = DifficultyLevel.new
  end

  # GET /difficulty_levels/1/edit
  def edit
  end

  # POST /difficulty_levels
  # POST /difficulty_levels.json
  def create
    @difficulty_level = DifficultyLevel.new(difficulty_level_params)

    respond_to do |format|
      if @difficulty_level.save
        format.html { redirect_to difficulty_levels_url, notice: 'Nivel de dificultad creado con éxito.' }
        format.json { render :show, status: :created, location: @difficulty_level }
      else
        format.html { render :new }
        format.json { render json: @difficulty_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /difficulty_levels/1
  # PATCH/PUT /difficulty_levels/1.json
  def update
    respond_to do |format|
      if @difficulty_level.update(difficulty_level_params)
        format.html { redirect_to difficulty_levels_url, notice: 'Nivel de dificultad actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @difficulty_level }
      else
        format.html { render :edit }
        format.json { render json: @difficulty_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /difficulty_levels/1
  # DELETE /difficulty_levels/1.json
  def destroy
    @difficulty_level.destroy
    respond_to do |format|
      format.html { redirect_to difficulty_levels_url, notice: 'Nivel de dificultad borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_difficulty_level
    @difficulty_level = DifficultyLevel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def difficulty_level_params
    params.require(:difficulty_level).permit(:name)
  end

  def set_admin_menu
    @admin_menu = true
  end
end
