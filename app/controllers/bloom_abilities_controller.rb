class BloomAbilitiesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_bloom_ability, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu
  # GET /bloom_abilities
  # GET /bloom_abilities.json
  def index
    @bloom_abilities = BloomAbility.all
    @bloom_ability = BloomAbility.new
    respond_to do |format|
      format.html
      format.json { render json: BloomAbilityDatatable.new(view_context) }
    end
  end

  # GET /bloom_abilities/1
  # GET /bloom_abilities/1.json
  def show
  end

  # GET /bloom_abilities/new
  def new
    @bloom_ability = BloomAbility.new
  end

  # GET /bloom_abilities/1/edit
  def edit
  end

  # POST /bloom_abilities
  # POST /bloom_abilities.json
  def create
    @bloom_ability = BloomAbility.new(bloom_ability_params)

    respond_to do |format|
      if @bloom_ability.save
        format.html { redirect_to bloom_abilities_url, notice: 'Habilidad cognitiva creada con éxito.' }
        format.json { render :show, status: :created, location: @bloom_ability }
      else
        format.html { render :new }
        format.json { render json: @bloom_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bloom_abilities/1
  # PATCH/PUT /bloom_abilities/1.json
  def update
    respond_to do |format|
      if @bloom_ability.update(bloom_ability_params)
        format.html { redirect_to bloom_abilities_url, notice: 'Habilidad cognitiva actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @bloom_ability }
      else
        format.html { render :edit }
        format.json { render json: @bloom_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bloom_abilities/1
  # DELETE /bloom_abilities/1.json
  def destroy
    @bloom_ability.destroy
    respond_to do |format|
      format.html { redirect_to bloom_abilities_url, notice: 'Habilidad cognitiva borrada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bloom_ability
    @bloom_ability = BloomAbility.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bloom_ability_params
    params.require(:bloom_ability).permit(:nombre, :descripcion)
  end

  def set_admin_menu
    @admin_menu = true
  end
end
