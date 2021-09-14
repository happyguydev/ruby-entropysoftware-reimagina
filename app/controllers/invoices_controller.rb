class InvoicesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :toggle_approve]
  before_action :set_order
  before_action :set_admin_menu

  # GET /invoices
  # GET /invoices.json
  def index
    @invoice = Invoice.new
    @invoices = @order.invoices
    respond_to do |format|
      format.html
      format.json { render json: InvoiceDatatable.new(view_context, order_id: @order.id) }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice.order = @order
    @invoice = Invoice.new
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.order = @order
    respond_to do |format|
      if @invoice.save
        #format.html { redirect_to order_invoices_path(@order), notice: 'Factura agregada con éxito.' }
        format.html { redirect_to :back, notice: 'Factura agregada con éxito.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new  }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to :back, notice: 'Factura actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Factura borrada con éxito.' }
      format.json { head :no_content }
    end
  end

 def toggle_approve
    @invoice.toggle!(:paid)  
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
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:order_id, :numero, :fecha, :monto, :document, :paid)
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_admin_menu
    @admin_menu = true
  end
end
