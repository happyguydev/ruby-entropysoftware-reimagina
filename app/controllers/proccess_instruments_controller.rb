class ProccessInstrumentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_proccess_instrument, only: [:show, :edit, :update, :destroy,:destroy_answers]
  before_action :set_proccess, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_order, except: [:admin, :destroy_answers]
  before_action :set_admin_menu, only: [:admin]

  # GET /proccess_instruments
  # GET /proccess_instruments.json
  def index
    @proccess_instrument = ProccessInstrument.new
    #@proccess_instruments = @proccess.instruments
    respond_to do |format|
      format.html
      format.json { render json: ProccessInstrumentDatatable.new(view_context, params[:proccess_id].try(:to_i)) }
    end
  end

  # GET /proccess_instruments/1
  # GET /proccess_instruments/1.json
  def show
    #    @proccess.order = @order
    #    @proccess = Proccess.new
    #    @proccess_instrument.proccess = @proccess
    #    @proccess_instrument = ProccessInstrument.new
    @proccess_intrument = ProccessInstrument.new

  end

  # GET /proccess_instruments/new
  def new
    @proccess_instrument = ProccessInstrument.new
  end

  # GET /proccess_instruments/1/edit
  def edit
  end

  # POST /proccess_instruments
  # POST /proccess_instruments.json
  def create
    @proccess_instrument = ProccessInstrument.new(proccess_instrument_params)
    @proccess_instrument.proccess = @proccess
    respond_to do |format|
      if @proccess_instrument.save
        format.html { redirect_to order_proccess_proccess_instruments_path(@order,@proccess), notice: 'Proccess instrument was successfully created.' }
        format.json { render :show, status: :created, location: @proccess_instrument }
      else
        format.html { render :new }
        format.json { render json: @proccess_instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proccess_instruments/1
  # PATCH/PUT /proccess_instruments/1.json
  def update
    respond_to do |format|
      if @proccess_instrument.update(proccess_instrument_params)
        format.html { redirect_to order_proccess_proccess_instruments_path(@order,@proccess), notice: 'Proccess instrument was successfully updated.' }
        format.json { render :show, status: :ok, location: @proccess_instrument }
      else
        format.html { render :edit }
        format.json { render json: @proccess_instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proccess_instruments/1
  # DELETE /proccess_instruments/1.json
  def destroy
    @proccess_instrument.destroy
    respond_to do |format|
      format.html { redirect_to order_proccess_proccess_instruments_path(@order,@proccess), notice: 'Proccess instrument was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_answers
    @proccess_instrument.answers.destroy_all
    @proccess_instrument.update_attributes(report_generated: false)
    respond_to do |format|
      format.html { redirect_to admin_proccess_instruments_path, notice: 'Respuestas eliminadas exitosamente' }
      format.json { head :no_content }
    end
  end
  def admin
    @proccess_instruments = ProccessInstrument.all
    respond_to do |format|
      format.html
      format.json { render json: ProccessInstrumentAdminDatatable.new(view_context) }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_proccess_instrument
    @proccess_instrument = ProccessInstrument.find(params[:id])

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def proccess_instrument_params
    params.require(:proccess_instrument).permit(:proccess_id, :instrument_id)
  end

  def set_proccess
    @proccess = Proccess.find(params[:proccess_id])
  end

  def set_admin_menu
    @admin_menu = true
  end

  def set_order
    @order = Order.find(params[:order_id])
  end
end
