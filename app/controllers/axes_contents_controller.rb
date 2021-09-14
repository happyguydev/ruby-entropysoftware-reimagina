class AxesContentsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_axes_content, only: [:show, :edit, :update, :destroy]
  before_action :set_axis
  before_action :set_admin_menu

  # GET /axes_contents
  # GET /axes_contents.json
  def index
    @axes_contents = @axis.axes_contents

    respond_to do |format|
      format.html
      format.json { render json: AxisContentDatatable.new(view_context, axis_id: @axis.id) }
    end

  end

  # GET /axes_contents/1
  # GET /axes_contents/1.json
  def show
    @axes_content.axis = @axis
  end

  # GET /axes_contents/new
  def new
    @axes_content = AxesContent.new
  end

  # GET /axes_contents/1/edit
  def edit
  end

  # POST /axes_contents
  # POST /axes_contents.json
  def create
    @axes_content = AxesContent.new(axes_content_params)
    @axis.axes_contents << @axes_content

    respond_to do |format|
      if @axes_content.save
        format.html { redirect_to axis_path(@axes_content.axis), notice: 'Contenido de Eje creado con éxito.' }
        format.json { render :show, status: :created, location: @axes_content }
      else
        format.html { render :new }
        format.json { render json: @axes_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /axes_contents/1
  # PATCH/PUT /axes_contents/1.json
  def update
    respond_to do |format|
      if @axes_content.update(axes_content_params)
        format.html { redirect_to axis_path(@axes_content.axis), notice: 'Contenido de Eje actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @axes_content }
      else
        format.html { render :edit }
        format.json { render json: @axes_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /axes_contents/1
  # DELETE /axes_contents/1.json
  def destroy
    @axes_content.destroy
    respond_to do |format|
      format.html {  redirect_to axis_path(@axes_content.axis), notice: 'Contenido de Eje borrado con éxito.'}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_axes_content
    @axes_content = AxesContent.find(params[:id])
  end

  def set_axis
    @axis = Axis.find(params[:axis_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def axes_content_params
    params.require(:axes_content).permit(:axis_id, :nombre, :descripcion)
  end

  def set_admin_menu
    @admin_menu = true
  end
end
