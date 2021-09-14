class AssignatureAbilitiesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_assignature_ability, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu

  # GET /assignature_abilities
  # GET /assignature_abilities.json
  def index
    @assignature_ability = AssignatureAbility.new
    @assignature_abilities = AssignatureAbility.all

    respond_to do |format|
      format.html
      format.json { render json: AssignatureAbilityDatatable.new(view_context) }
    end
  end

  # GET /assignature_abilities/1
  # GET /assignature_abilities/1.json
  def show
  end

  # GET /assignature_abilities/new
  def new
    @assignature_ability = AssignatureAbility.new
  end

  # GET /assignature_abilities/1/edit
  def edit
  end

  # POST /assignature_abilities
  # POST /assignature_abilities.json
  def create
    @assignature_ability = AssignatureAbility.new(assignature_ability_params)

    respond_to do |format|
      if @assignature_ability.save
        format.html { redirect_to assignature_abilities_url, notice: 'Habilidad de la asignatura creada con éxito.' }
        format.json { render :show, status: :created, location: @assignature_ability }
      else
        format.html { render :new }
        format.json { render json: @assignature_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignature_abilities/1
  # PATCH/PUT /assignature_abilities/1.json
  def update
    respond_to do |format|
      if @assignature_ability.update(assignature_ability_params)
        format.html { redirect_to assignature_abilities_url, notice: 'Habilidad de la asignatura actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @assignature_ability }
      else
        format.html { render :edit }
        format.json { render json: @assignature_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignature_abilities/1
  # DELETE /assignature_abilities/1.json
  def destroy
    @assignature_ability.destroy
    respond_to do |format|
      format.html { redirect_to assignature_abilities_url, notice: 'Habilidad de la asignatura borrada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_assignature_ability
    @assignature_ability = AssignatureAbility.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def assignature_ability_params
    params.require(:assignature_ability).permit(:nombre, :descripcion, :assignature_id)
  end

  def set_admin_menu
    @admin_menu = true
  end
end
