class OrderStatusesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_order_status, only: [:show, :edit, :update, :destroy]
  before_action :set_order
  before_action :set_admin_menu

  # GET /order_statuses
  # GET /order_statuses.json
  def index
    @order_status = OrderStatus.new
  end

  # GET /order_statuses/1
  # GET /order_statuses/1.json
  def show
    @order_status.order = @order
    @order_status = OrderStatus.new
  end

  # GET /order_statuses/new
  def new
    @order_status = OrderStatus.new
  end

  # GET /order_statuses/1/edit
  def edit
  end

  # POST /order_statuses
  # POST /order_statuses.json
  def create
    @order_status = OrderStatus.new(order_status_params)
    @order_status.order = @order
    respond_to do |format|
      if @order_status.save
        format.html { redirect_to :back, notice: 'Estado de orden creado con éxito' }
        format.json { render :show, status: :created, location: @order_status }
      else
        format.html { render :new }
        format.json { render json: @order_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_statuses/1
  # PATCH/PUT /order_statuses/1.json
  def update
    respond_to do |format|
      if @order_status.update(order_status_params)
        format.html { redirect_to order_order_statuses_path(@order), notice: 'Estado de orden actualizado con éxito' }
        format.json { render :show, status: :ok, location: @order_status }
      else
        format.html { render :edit }
        format.json { render json: @order_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_statuses/1
  # DELETE /order_statuses/1.json
  def destroy
    @order_status.destroy
    respond_to do |format|
      format.html { redirect_to order_order_statuses_path(@order), notice: 'Estado de orden borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order_status
    @order_status = OrderStatus.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_status_params
    params.require(:order_status).permit(:order_id, :status_type_id, :comentario)
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_admin_menu
    @admin_menu = true
  end

end
