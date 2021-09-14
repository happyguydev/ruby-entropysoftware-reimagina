class PmeAbilitiesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_pme_ability, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu
  
  # GET /pme_abilities
  # GET /pme_abilities.json
  def index
    @pme_ability = PmeAbility.new
    @pme_abilities = PmeAbility.all
    respond_to do |format|
      format.html
      format.json { render json: PmeAbilityDatatable.new(view_context) }
    end
  end

  # GET /pme_abilities/1
  # GET /pme_abilities/1.json
  def show

    @ability_content = AbilityContent.new

  end

  # GET /pme_abilities/new
  def new
    @pme_ability = PmeAbility.new
  end

  # GET /pme_abilities/1/edit
  def edit
  end

  # POST /pme_abilities
  # POST /pme_abilities.json
  def create
    @pme_ability = PmeAbility.new(pme_ability_params)

    respond_to do |format|
      if @pme_ability.save
        format.html { redirect_to pme_abilities_url, notice: 'Habilidad PME creada con éxito.' }
        format.json { render :show, status: :created, location: @pme_ability }
      else
        format.html { render :new }
        format.json { render json: @pme_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pme_abilities/1
  # PATCH/PUT /pme_abilities/1.json
  def update
    respond_to do |format|
      if @pme_ability.update(pme_ability_params)
        format.html { redirect_to pme_abilities_url, notice: 'Habilidad PME actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @pme_ability }
      else
        format.html { render :edit }
        format.json { render json: @pme_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pme_abilities/1
  # DELETE /pme_abilities/1.json
  def destroy
    @pme_ability.destroy
    respond_to do |format|
      format.html { redirect_to pme_abilities_url, notice: 'Habilidad PME borrada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pme_ability
    @pme_ability = PmeAbility.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pme_ability_params
    params.require(:pme_ability).permit(:nombre, :descripcion, :assignature_id)
  end
  
  def set_admin_menu
    @admin_menu = true
  end
end
