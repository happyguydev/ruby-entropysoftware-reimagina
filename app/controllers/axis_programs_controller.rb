class AxisProgramsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_axis_program, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu

  # GET /axis_programs
  # GET /axis_programs.json
  def index
    @axis_programs = AxisProgram.all
    @axis_program = AxisProgram.new
    
    respond_to do |format|
      format.html
      format.json { render json: AxisProgramDatatable.new(view_context) }
    end

  end

  # GET /axis_programs/1
  # GET /axis_programs/1.json
  def show
  end

  # GET /axis_programs/new
  def new
    @axis_program = AxisProgram.new
  end

  # GET /axis_programs/1/edit
  def edit
  end

  # POST /axis_programs
  # POST /axis_programs.json
  def create
    @axis_program = AxisProgram.new(axis_program_params)

    respond_to do |format|
      if @axis_program.save
        format.html { redirect_to @axis_program, notice: 'Axis program was successfully created.' }
        format.json { render :show, status: :created, location: @axis_program }
      else
        format.html { render :new }
        format.json { render json: @axis_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /axis_programs/1
  # PATCH/PUT /axis_programs/1.json
  def update
    respond_to do |format|
      if @axis_program.update(axis_program_params)
        format.html { redirect_to @axis_program, notice: 'Axis program was successfully updated.' }
        format.json { render :show, status: :ok, location: @axis_program }
      else
        format.html { render :edit }
        format.json { render json: @axis_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /axis_programs/1
  # DELETE /axis_programs/1.json
  def destroy
    @axis_program.destroy
    respond_to do |format|
      format.html { redirect_to axis_programs_url, notice: 'Axis program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_axis_program
    @axis_program = AxisProgram.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def axis_program_params
    params.require(:axis_program).permit(:nombre, :descripcion, :assignature_id)
  end

  def set_admin_menu
    @admin_menu = true
  end
end
