class FactStatusesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_fact_status, only: [:show, :edit, :update, :destroy]

  # GET /fact_statuses
  # GET /fact_statuses.json
  def index
    @fact_statuses = FactStatus.all
  end

  # GET /fact_statuses/1
  # GET /fact_statuses/1.json
  def show
  end

  # GET /fact_statuses/new
  def new
    @fact_status = FactStatus.new
  end

  # GET /fact_statuses/1/edit
  def edit
  end

  # POST /fact_statuses
  # POST /fact_statuses.json
  def create
    @fact_status = FactStatus.new(fact_status_params)

    respond_to do |format|
      if @fact_status.save
        format.html { redirect_to @fact_status, notice: 'Fact status was successfully created.' }
        format.json { render :show, status: :created, location: @fact_status }
      else
        format.html { render :new }
        format.json { render json: @fact_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fact_statuses/1
  # PATCH/PUT /fact_statuses/1.json
  def update
    respond_to do |format|
      if @fact_status.update(fact_status_params)
        format.html { redirect_to @fact_status, notice: 'Fact status was successfully updated.' }
        format.json { render :show, status: :ok, location: @fact_status }
      else
        format.html { render :edit }
        format.json { render json: @fact_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fact_statuses/1
  # DELETE /fact_statuses/1.json
  def destroy
    @fact_status.destroy
    respond_to do |format|
      format.html { redirect_to fact_statuses_url, notice: 'Fact status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fact_status
      @fact_status = FactStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fact_status_params
      params.require(:fact_status).permit(:order_id, :fact_status_type_id, :comentario)
    end
end
