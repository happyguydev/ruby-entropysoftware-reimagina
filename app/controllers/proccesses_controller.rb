class ProccessesController < ApplicationController
  load_and_authorize_resource

  before_action :set_proccess, only: [:show, :edit, :update, :destroy, :add_instrument, :remove_instrument]
  before_action :set_order
  before_action :set_admin_menu

  # GET /proccesses
  # GET /proccesses.json
  def index
    @proccess = Proccess.new
    @proccesses = @order.proccesses
    respond_to do |format|
      format.html
      format.json { render json: ProccessDatatable.new(view_context, order_id: @order.id) }
    end
  end

  # GET /proccesses/1
  # GET /proccesses/1.json
  def show
    @proccess_instrument = ProccessInstrument.new
    @grades_level = @order.try(:school).try(:grades).map { |g| [ "#{g.try(:level).try(:nombre)} #{g.try(:letra)}", g.try(:id) ] }
  end

  # GET /proccesses/new
  def new
    @proccess = Proccess.new
  end

  # GET /proccesses/1/edit
  def edit
  end

  # POST /proccesses
  # POST /proccesses.json
  def create
    @proccess = Proccess.new(proccess_params)
    @proccess.order = @order

    respond_to do |format|
      if @proccess.save
        format.html { redirect_to order_proccesses_path(@order), notice: 'Proceso creado con éxito.' }
        format.json { render :show, status: :created, location: @proccess }
        #Payment.generate_cuotas(@order.id, @proccess.proc_type.nombre, @proccess.monto, @proccess.cuotas, @proccess.fecha_cuota)

      else
        format.html { render :new }
        format.json { render json: @proccess.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proccesses/1
  # PATCH/PUT /proccesses/1.json
  def update
    respond_to do |format|
      if @proccess.update(proccess_params)
        format.html { redirect_to order_proccesses_path(@order), notice: 'Proceso actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @proccess }
      else
        format.html { render :edit }
        format.json { render json: @proccess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proccesses/1
  # DELETE /proccesses/1.json
  def destroy
    @proccess.destroy
    respond_to do |format|
      format.html { redirect_to order_proccesses_path(@order), notice: 'Proceso borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  def add_instrument
    if @proccess.instruments.where(id: params[:instrument_id]).count == 0
      #@proccess.instruments << Instrument.find(params[:instrument_id])
      level = Instrument.find(params[:instrument_id]).evaluation.level.id
      grades = @proccess.order.school.grades.where(:level_id => level ).where(:year => @proccess.order.year)

      grades.each do |g|
        ProccessInstrument.create(instrument_id: params[:instrument_id], proccess: @proccess, grade: g )
      end
      @proccess.save
      render status: :ok, json: Instrument.find(params[:instrument_id])
    else
      render status: 500, json: Instrument.find(params[:instrument_id])
    end
  end

  def remove_instrument
    instrument = Instrument.find(params[:instrument_id])
    instrument.proccesses.delete(@proccess)
    if @proccess.save
      render status: :ok, json: Instrument.find(params[:instrument_id])
    else
      render status: 500, json: Instrument.find(params[:instrument_id])
    end
  end

def generate_cuotas

  cuotas =  params[:proccess][:cuotas].to_i
  fecha = params[:proccess][:fecha_cuota].to_date
  monto = @order.proccesses.where(:billed => nil).sum(:monto)
  @order.proccesses.where(:billed => nil).update_all(:billed => true)
  nombre = "Orden #{@order.number}"

   respond_to do |format|
     if cuotas > 0 && monto > 0
       monto = monto/cuotas
       cuotas.times do |i|
         fecha_cuota = fecha + i.month
         Payment.create(:order_id => @order.id, :monto => monto, :fecha => fecha_cuota, :comentario => "Cuota #{(i+1)} de #{cuotas} #{nombre}")
       end
       format.html { redirect_to order_proccesses_path(@order), notice: 'Cuotas ingresadas con éxito.' }
       format.json { render :show, status: :ok, location: @proccess }
     else
       if cuotas == 0
       format.html { redirect_to order_proccesses_path(@order),  :flash => { :error => "Seleccione al menos 1 cuota" } }
       format.json { render :show, status: :ok, location: @proccess }
        else
       format.html { redirect_to order_proccesses_path(@order),  :flash => { :error => "Cuotas ya generadas" } }
       format.json { render :show, status: :ok, location: @proccess }
      end
     end
   end

end
  #  def remove_instrument
  #    instru = Instrument.find(params[:instrument_id])
  #    procce = @proccess
  #    if procce
  #      instru.proccesses.delete(procce)
  #      render status: :ok, json: Instrument.find(params[:instrument_id])
  #    else
  #      render status: 500, json: Instrument.find(params[:instrument_id])
  #    end
  #  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_proccess
    @proccess = Proccess.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def proccess_params
    params.require(:proccess).permit(:order_id, :proc_type_id, :monto, :cuotas, :fecha_cuota, :fecha)
  end
  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_admin_menu
    @admin_menu = true
  end

end
