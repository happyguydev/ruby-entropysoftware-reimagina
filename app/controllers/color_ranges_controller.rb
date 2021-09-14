class ColorRangesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_color_range, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu

  # GET /color_ranges
  # GET /color_ranges.json
  def index
    @color_ranges = ColorRange.all
    @color_range = ColorRange.new

    respond_to do |format|
      format.html
      format.json { render json: ColorRangeDatatable.new(view_context) }
    end
  end

  # GET /color_ranges/1
  # GET /color_ranges/1.json
  def show
  end

  # GET /color_ranges/new
  def new
    @color_range = ColorRange.new
  end

  # GET /color_ranges/1/edit
  def edit
  end

  # POST /color_ranges
  # POST /color_ranges.json
  def create
    @color_range = ColorRange.new(color_range_params)

    respond_to do |format|
      if @color_range.save
        format.html { redirect_to color_ranges_url, notice: 'Rango creado con éxito' }
        format.json { render :show, status: :created, location: @color_range }
      else
        format.html { render :new }
        format.json { render json: @color_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /color_ranges/1
  # PATCH/PUT /color_ranges/1.json
  def update
    respond_to do |format|
      if @color_range.update(color_range_params)
        format.html { redirect_to color_ranges_url, notice: 'Rango actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @color_range }
      else
        format.html { render :edit }
        format.json { render json: @color_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /color_ranges/1
  # DELETE /color_ranges/1.json
  def destroy
    @color_range.destroy
    respond_to do |format|
      format.html { redirect_to color_ranges_url, notice: 'Rango borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_color_range
    @color_range = ColorRange.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def color_range_params
    params.require(:color_range).permit(:nombre, :min, :max, :color, :evaluation_type_id, :assignature_id,:level_id)
  end

  def set_admin_menu
    @admin_menu = true
  end
end
