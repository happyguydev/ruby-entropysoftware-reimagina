class ProcTypesController < ApplicationController
  load_and_authorize_resource
  before_action :set_proc_type, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu

  # GET /proc_types
  # GET /proc_types.json
    def index
        @proc_types = ProcType.all
        @proc_type = ProcType.new
        respond_to do |format|
            format.html
            format.json { render json: ProcTypeDatatable.new(view_context) }
        end
    end

  # GET /proc_types/1
  # GET /proc_types/1.json
  def show
  end

  # GET /proc_types/new
  def new
    @proc_type = ProcType.new
  end

  # GET /proc_types/1/edit
  def edit
  end

  # POST /proc_types
  # POST /proc_types.json
  def create
    @proc_type = ProcType.new(proc_type_params)

    respond_to do |format|
      if @proc_type.save
        format.html { redirect_to proc_types_url, notice: 'Tipo de proceso creado con éxito.' }
        format.json { render :show, status: :created, location: @proc_type }
      else
        format.html { render :new }
        format.json { render json: @proc_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proc_types/1
  # PATCH/PUT /proc_types/1.json
  def update
    respond_to do |format|
      if @proc_type.update(proc_type_params)
        format.html { redirect_to proc_types_url, notice: 'Tipo de proceso actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @proc_type }
      else
        format.html { render :edit }
        format.json { render json: @proc_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proc_types/1
  # DELETE /proc_types/1.json
  def destroy
    @proc_type.destroy
    respond_to do |format|
      format.html { redirect_to proc_types_url, notice: 'Tipo de proceso borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proc_type
      @proc_type = ProcType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proc_type_params
      params.require(:proc_type).permit(:nombre, :descripcion, :proc_type_father_id,:priority)
    end
        def set_admin_menu
        @admin_menu = true
    end
end
