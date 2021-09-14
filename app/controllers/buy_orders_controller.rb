class BuyOrdersController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_buy_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order
  before_action :set_admin_menu

  # GET /buy_orders
  # GET /buy_orders.json
  def index

    @buy_order = BuyOrder.new
    @buy_orders = @order.buy_orders

    respond_to do |format|
      format.html
      format.json { render json: BuyOrderDatatable.new(view_context, order_id: @order.id) }
    end
  end

  # GET /buy_orders/1
  # GET /buy_orders/1.json
  def show
  end

  # GET /buy_orders/new
  def new
    @buy_order = BuyOrder.new
  end

  # GET /buy_orders/1/edit
  def edit
  end

  # POST /buy_orders
  # POST /buy_orders.json
  def create
    @buy_order = BuyOrder.new(buy_order_params)
    @buy_order.order = @order

    respond_to do |format|
      if @buy_order.save
        format.html { redirect_to @order, notice: 'Orden de compra creada con éxito.' }
        format.json { render :show, status: :created, location: @buy_order }
      else
        format.html { render :new }
        format.json { render json: @buy_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buy_orders/1
  # PATCH/PUT /buy_orders/1.json
  def update
    respond_to do |format|
      if @buy_order.update(buy_order_params)
        format.html { redirect_to @order, notice: 'Orden de compra actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @buy_order }
      else
        format.html { render :edit }
        format.json { render json: @buy_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buy_orders/1
  # DELETE /buy_orders/1.json
  def destroy
    @buy_order.destroy
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Orden de compra borrada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_buy_order
    @buy_order = BuyOrder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def buy_order_params
    params.require(:buy_order).permit(:order_id, :monto, :fecha, :numero, :comentario,:document)
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_admin_menu
    @admin_menu = true
  end
end
