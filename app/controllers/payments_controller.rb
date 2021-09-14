class PaymentsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_payment, only: [:show, :edit, :update, :destroy, :toggle_approve]
  before_action :set_order
  before_action :set_admin_menu


  # GET /payments
  # GET /payments.json
  def index
    @payment = Payment.new
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment.order = @order
    @payment = Payment.new
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.order = @order
    respond_to do |format|
      if @payment.save
        format.html { redirect_to order_path(@order), anchor: 'order/#pagos', notice: 'Pago creado con éxito' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to order_path(@order), notice: 'Pago actualizado con éxito' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to order_path(@order), notice: 'Pago borrado con éxito' }
      format.json { head render inline: "location.reload();" }
    end
  end

  def toggle_approve
    @payment.toggle!(:paid)  
    #render :nothing => true  
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end  

  def approve_link_text(payment)
    if payment.present?
      payment.paid? ? '<i class="fa fa-usd" style="color: #5cb85c;"></i>'.html_safe : '<i class="fa fa-usd" style="color: #d9534f;"></i>'.html_safe 
    end
  end  
  helper_method :approve_link_text
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.require(:payment).permit(:order_id, :monto, :comentario, :fecha, :paid)
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_admin_menu
    @admin_menu = true
  end
end
