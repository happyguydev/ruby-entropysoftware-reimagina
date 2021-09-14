class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu
  layout :resolve_layout

  # GET /orders
  # GET /orders.json
  def index
    @order = Order.new
    @orders = Order.all
    respond_to do |format|
      format.html
      format.json { render json: OrderDatatable.new(view_context) }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    #empty objects
    @invoice = Invoice.new
    @buy_order = BuyOrder.new
    @order_status = OrderStatus.new
    @payment = Payment.new
    @proccess = Proccess.new

    #view data
    @cobrado = Proccess.where(:order => @order).sum(:monto)
    @sin_facturar = @order.try(:proccesses).sum(:monto) - @order.invoices.sum(:monto)
    @pagado = @order.payments.where(paid: [true]).sum(:monto)
    @adeudado = @cobrado - @order.payments.where(paid: true).sum(:monto)

    #encargado de cobranza va a ser usuario con rol cobranza, sino usuario con rol director, sino el primer usuario creado
    @encargado =  AssignedSchool.where(:school_id => @order.school.id).includes(:user => :user_type).where("user_types.code" => "COBRANZA").try(:first).try(:user) || AssignedSchool.where(:school_id => @order.school.id).includes(:user => :user_type).where("user_types.code" => "DIRECTOR").try(:first).try(:user) || @order.try(:school).try(:users).try(:first) 
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  def cobranza
    @orders = Order.where.not(:number => nil).where(:year => DateTime.now.year)
    @cant_ordenes = Order.where(:year => DateTime.now.year).where.not(:number => nil).count
    @facturado = @orders.joins(:invoices).sum('invoices.monto')
    @cobrado = Order.joins(:proccesses).where(:year => DateTime.now.year).sum('proccesses.monto')
    #@adeudado = Payment.where('extract(year from fecha) = ?', DateTime.now.year).where(:paid => [false,nil]).sum(:monto)
    @nofacturado = @cobrado - @facturado
    @pagado = @orders.joins(:payments).where('payments.paid = true').sum('payments.monto')
    @adeudado = @cobrado - @pagado


    respond_to do |format|
      format.html
      format.json { render json: CollectionDatatable.new(view_context) }
    end
  end

  def historico
    @orders = Order.all
    @cant_ordenes = @orders.count
    @facturado = @orders.joins(:invoices).sum('invoices.monto')
    @cobrado = Order.joins(:proccesses).sum('proccesses.monto')
    @pagado = @orders.joins(:payments).where('payments.paid = true').sum('payments.monto')
    @adeudado = @cobrado - @pagado
    @nofacturado = @cobrado - @pagado

    respond_to do |format|
      format.html
      format.json { render json: HistoricoDatatable.new(view_context) }
    end
  end

 def facturas
    #[year, total facturado, total no facturado, total cobrado, total adeudado, total pagado, cantidad ordenes, cantidad facturas]
    @resumen = []

    years = Order.where.not(:number => nil).group(:year).count
    active_years = years.map{|k,v| k}.sort

    active_years.each do |y|
      inner = []
      orders = Order.where(:year => y).where.not(:number => nil)
      facturado = orders.joins(:invoices).sum('invoices.monto')
      cobrado = orders.joins(:proccesses).sum('proccesses.monto')
      pagado = orders.joins(:payments).where('payments.paid = true').sum('payments.monto')
      adeudado = cobrado - pagado
      no_facturado = cobrado - facturado
      cant_ordenes = orders.count
      cant_facturas = orders.joins(:invoices).count(:invoices)
      cant_oc = orders.joins(:buy_orders).count(:buy_orders)
      inner.push(y, facturado,no_facturado,cobrado,adeudado,pagado,cant_ordenes,cant_facturas,cant_oc)
      @resumen.push(inner)
    end
    @resumen
    respond_to do |format|
      format.html
      format.json { render json: FacturaDatatable.new(view_context) }
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    ordernum = Order.where.not(number: nil)
    @order = Order.new(order_params)

    if ordernum.count > 0
      @order.number = ordernum.last.number+1
    else
      @order.number = 1
    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: 'Orden creada con éxito.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def mass_input
    @data = JSON.parse(params[:form_data])
    #Recorrer formulario creando colegio, luego la orden, luego los procesos
    respond_to do |format|
      mass_order_school_params.each do |sc|
        #buscar si existe colegio en sistema, sino crearlo
        actual_school = School.find_or_create_by(:rbd => sc[:rbd], :nombre => sc[:nombre]) do |ssc|
          ssc.rut = sc[:rut]
          ssc.dependencia = sc[:dependencia]
          ssc.commune_id = sc[:commune_id]
          ssc.direccion = "ND"
          ssc.telefono = sc[:eva_telefono]
          ssc.email = sc[:eva_mail]
        end
        #buscar si existe orden asociada a ese colegio en ese año, sino crearla
        actual_order = Order.find_or_create_by(:school => actual_school, :year => sc[:year]) do |ao|
          ao.contract = sc[:contract]
          ao.paymethod = sc[:paymethod]
        end
        #agregar proceso del registro actual a la orden
        pro = Proccess.find_or_create_by(:order => actual_order,:proc_type_id => sc[:proc_type_id] )
        actual_order.proccesses << pro
        #crear las cuentas de usuario, si ya esta registrado el mail no hacer nada porque partimos con la cuenta director que tiene
        #todos los privilegios

        #creamos al director
        if sc[:eva_mail].length > 1
        rol = UserType.where(:code => "DIRECTOR").first
        u = User.create(:email => sc[:eva_mail], :first_name =>  sc[:eva_nombre], :tel => sc[:eva_telefono], :user_type => rol, :password =>('a'..'z').to_a.shuffle[0,8].join, :second_name => "_")
          if u.save
            u.schools << actual_school
          end
        end
        #creamos al utp
        if sc[:resul_mail].length > 1
        rol = UserType.where(:code => "UTP").first
        u = User.create(:email => sc[:resul_mail], :first_name =>  sc[:resul_nombre], :tel => sc[:resul_telefono], :user_type => rol, :password =>('a'..'z').to_a.shuffle[0,8].join, :second_name => "_")
          if u.save
            u.schools << actual_school
          end
        end
        #creamos a cobranza
        if sc[:fact_mail].length > 1
        rol = UserType.where(:code => "COBRANZA").first
        u = User.create(:email => sc[:fact_mail], :first_name =>  sc[:fact_nombre], :tel => sc[:fact_telefono], :user_type => rol, :password => ('a'..'z').to_a.shuffle[0,8].join, :second_name => "_")
          if u.save
            u.schools << actual_school
          end
        end
      end

      if mass_order_school_params.count > 0
        format.html { redirect_to orders_url, notice: 'Ingreso masivo exitoso' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_url, notice: 'Orden actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Orden borrada con éxito.'}
      format.json { head :no_content }
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
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:pay_status_id, :mora, :status_type_id,:school_id, :year, :paymethod,:payer_type_id, :contract, :licitacion,:service_type_id,:can_download,proccesses_attributes: [:id, :proc_type_id,:fecha,:monto,:_destroy])
  end

  def mass_order_school_params
    data = JSON.parse(params[:form_data])['mass_orders']
    #pasar a hash los datos del formulario para mayor comodidad
    data.reject { |s| s[0] == "Formulario" }.map{|info|
      {
        #params para crear el colegio
        :commune_id => Commune.where('name ILIKE ?', "%"+info[8].to_s.strip || 1 +"%" ).last.try(:id),
        #:commune_id => Commune.where("unaccent(name) ILIKE unaccent(?)", "%"+info[8].to_s.strip || 1 +"%").last.try(:id),
        :rbd => info[5],
        :nombre => info[7],
        :rut => info[11],
        :dependencia => info[12],
        :eva_nombre => info[13],
        :eva_mail => info[14],
        :eva_cargo => info[15],
        :eva_telefono => info[16],
        :resul_nombre => info[17],
        :resul_mail => info[18],
        :resul_cargo => info[19],
        :resul_telefono => info[20],
        :fact_nombre => info[21],
        :fact_mail => info[22],
        :fact_telefono => info[23],

        #params para crear la orden
        :contract => info[1],
        :year => info[4].try(:to_date).try(:year),
        :paymethod => info[10],

        #params para agregar el proceso
        :proc_type_id =>ProcType.find_or_create_by(:nombre => info[3]).id,
        }
      }.select{|attrs| attrs[:nombre].present?}
  end

  def set_admin_menu
    @admin_menu = true
  end

  def resolve_layout
    case action_name
    when "show"
      "nomenu"
    else
      "application"
    end
  end
end
