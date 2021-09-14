class CollectionDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :order_path, :edit_order_path


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
      'Order.number',
      'Order.year',
      'School.rbd',
      'School.nombre',
      'Commune.name',
      'Region.roman',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.paydate',
      'School.rut',
      'PayerType.nombre',
      'Order.id',
      'Order.paydate',
      'Order.paymethod',
      'StatusType.nombre',
      'OrderStatus.comentario'
      ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
      'Order.number',
      'Order.year',
      'School.rbd',
      'School.nombre',
      'Commune.name',
      'Region.roman',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.paydate',
      'School.rut',
      'PayerType.nombre',
      'Order.id',
      'Order.paydate',
      'Order.paymethod',
      'StatusType.nombre',
      'OrderStatus.comentario'
      ]
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        #link_to(record.school.try(:nombre), order_path(record), :target => '_blank'), 
        record.try(:number),
        record.try(:year),
        record.school.try(:rbd),
        link_to(record.school.try(:nombre), order_path(record), :target => '_blank'),
        record.school.try(:commune).try(:name),
        record.school.try(:commune).try(:region).try(:name),
        [get_encargado(record).try(:first_name),get_encargado(record).try(:second_name)].compact.join(" "),
        get_encargado(record).try(:tel),
        get_encargado(record).try(:email),
        record.invoices.try(:last).try(:numero),
        get_mora(record),
        record.try(:school).try(:rut),
        record.try(:payer_type).try(:nombre),
        record.proccesses.map{|p| p.try(:proc_type).try(:nombre)}.uniq,
        record.try(:paydate),
        record.try(:paymethod),
        record.try(:status_type).try(:nombre),
        record.order_statuses.try(:last).try(:comentario)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Order.where.not(number: nil).includes(
      :payer_type,:status_type,:school => { :commune => :region }, :order_statuses => :status_type
      )
    .references(
      :payer_type,:status_type,:school => { :commune => :region }, :order_statuses => :status_type
      ).distinct
  end

  def get_encargado(record)
    #encargado de cobranza va a ser usuario con rol cobranza, sino usuario con rol director, sino el primer usuario creado
    encargado =  AssignedSchool.where(:school_id => record.school.id).includes(:user => :user_type).where("user_types.code" => "COBRANZA").try(:first).try(:user) || AssignedSchool.where(:school_id => record.school.id).includes(:user => :user_type).where("user_types.code" => "DIRECTOR").try(:first).try(:user) || record.try(:school).try(:users).try(:first) 
  end

  def get_mora(record)
    factura = record.try(:paydate)
    #factura = record.try(:payments).where(:paid => [nil, false]).order(:fecha).first.try(:fecha)
    if  factura != nil
      (factura..DateTime.now).count
    else
      0
    end
  end
  # ==== Insert 'presenter'-like methods below if necessary
end
