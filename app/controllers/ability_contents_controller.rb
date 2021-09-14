class AbilityContentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ability_content, only: [:show, :edit, :update, :destroy]
  before_action :set_pme_ability
  before_action :set_admin_menu
	# GET /ability_contents
	# GET /ability_contents.json
	def index

		@ability_contents = @pme_ability.ability_contents

		respond_to do |format|
			format.html
			format.json { render json: AbilityContentDatatable.new(view_context, pme_ability_id: @pme_ability.id) }
		end
	end

	# GET /ability_contents/1
	# GET /ability_contents/1.json
	def show
		@ability_content.pme_ability = @pme_ability
	end

	# GET /ability_contents/new
	def new
		
		@ability_content = AbilityContent.new
	end

	# GET /ability_contents/1/edit
	def edit
	end

	# POST /ability_contents
	# POST /ability_contents.json
	def create
		@ability_content = AbilityContent.new(ability_content_params)
		@pme_ability.ability_contents << @ability_content
		
		respond_to do |format|
			if @ability_content.save
				format.html { redirect_to pme_ability_path(@ability_content.pme_ability), notice: 'Contenido Habilidad creado con éxito.' }
				format.json { render :show, status: :created, location: @ability_content }
			else
				format.html { render :new }
				format.json { render json: @ability_content.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /ability_contents/1
	# PATCH/PUT /ability_contents/1.json
	def update
		respond_to do |format|
			if @ability_content.update(ability_content_params)
				format.html { redirect_to pme_ability_path(@ability_content.pme_ability), notice: 'Contenido Habilidad actualizado con éxito.' }
				format.json { render :show, status: :ok, location: @ability_content }
			else
				format.html { render :edit }
				format.json { render json: @ability_content.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /ability_contents/1
	# DELETE /ability_contents/1.json
	def destroy
		@ability_content.destroy
		respond_to do |format|
			format.html { redirect_to pme_ability_path(@pme_ability), notice: 'Contenido Habilidad borrado con éxito.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_ability_content
		@ability_content = AbilityContent.find(params[:id])
	end

	def set_pme_ability
		@pme_ability = PmeAbility.find(params[:pme_ability_id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def ability_content_params
		params.require(:ability_content).permit(:pme_ability_id, :nombre, :descripcion)
	end

	def set_admin_menu
		@admin_menu = true
	end
end
