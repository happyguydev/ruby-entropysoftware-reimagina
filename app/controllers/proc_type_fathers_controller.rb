class ProcTypeFathersController < ApplicationController
  before_action :set_proc_type_father, only: [:show, :edit, :update, :destroy]

  # GET /proc_type_fathers
  # GET /proc_type_fathers.json
  def index
    @proc_type_fathers = ProcTypeFather.all
  end

  # GET /proc_type_fathers/1
  # GET /proc_type_fathers/1.json
  def show
  end

  # GET /proc_type_fathers/new
  def new
    @proc_type_father = ProcTypeFather.new
  end

  # GET /proc_type_fathers/1/edit
  def edit
  end

  # POST /proc_type_fathers
  # POST /proc_type_fathers.json
  def create
    @proc_type_father = ProcTypeFather.new(proc_type_father_params)

    respond_to do |format|
      if @proc_type_father.save
        format.html { redirect_to @proc_type_father, notice: 'Proc type father was successfully created.' }
        format.json { render :show, status: :created, location: @proc_type_father }
      else
        format.html { render :new }
        format.json { render json: @proc_type_father.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proc_type_fathers/1
  # PATCH/PUT /proc_type_fathers/1.json
  def update
    respond_to do |format|
      if @proc_type_father.update(proc_type_father_params)
        format.html { redirect_to @proc_type_father, notice: 'Proc type father was successfully updated.' }
        format.json { render :show, status: :ok, location: @proc_type_father }
      else
        format.html { render :edit }
        format.json { render json: @proc_type_father.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proc_type_fathers/1
  # DELETE /proc_type_fathers/1.json
  def destroy
    @proc_type_father.destroy
    respond_to do |format|
      format.html { redirect_to proc_type_fathers_url, notice: 'Proc type father was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proc_type_father
      @proc_type_father = ProcTypeFather.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proc_type_father_params
      params.require(:proc_type_father).permit(:nombre, :short_name)
    end
end
