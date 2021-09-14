class FactStatusTypesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_fact_status_type, only: [:show, :edit, :update, :destroy]

  # GET /fact_status_types
  # GET /fact_status_types.json
  def index
    @fact_status_types = FactStatusType.all
  end

  # GET /fact_status_types/1
  # GET /fact_status_types/1.json
  def show
  end

  # GET /fact_status_types/new
  def new
    @fact_status_type = FactStatusType.new
  end

  # GET /fact_status_types/1/edit
  def edit
  end

  # POST /fact_status_types
  # POST /fact_status_types.json
  def create
    @fact_status_type = FactStatusType.new(fact_status_type_params)

    respond_to do |format|
      if @fact_status_type.save
        format.html { redirect_to @fact_status_type, notice: 'Fact status type was successfully created.' }
        format.json { render :show, status: :created, location: @fact_status_type }
      else
        format.html { render :new }
        format.json { render json: @fact_status_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fact_status_types/1
  # PATCH/PUT /fact_status_types/1.json
  def update
    respond_to do |format|
      if @fact_status_type.update(fact_status_type_params)
        format.html { redirect_to @fact_status_type, notice: 'Fact status type was successfully updated.' }
        format.json { render :show, status: :ok, location: @fact_status_type }
      else
        format.html { render :edit }
        format.json { render json: @fact_status_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fact_status_types/1
  # DELETE /fact_status_types/1.json
  def destroy
    @fact_status_type.destroy
    respond_to do |format|
      format.html { redirect_to fact_status_types_url, notice: 'Fact status type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fact_status_type
      @fact_status_type = FactStatusType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fact_status_type_params
      params.require(:fact_status_type).permit(:nombre)
    end
end
