class OrderDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :order_path, :edit_order_path, :order_proccesses_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
      'Order.number',
      'Order.year',
      'School.rbd',
      'School.nombre',
      'Commune.name',
      'Region.name',
      'School.dependencia',
      'School.rut',
      'PayerType.nombre',
      'Order.number',
      'Order.contract',
      'ServiceType.name',
      'PayStatus.nombre',
      'Order.number'

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
      'Region.name',
      'School.dependencia',
      'School.rut',
      'PayerType.nombre',
      'Order.number',
      'Order.contract',
      'ServiceType.name',
      'PayStatus.nombre',
      'Order.number'
      ]
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.try(:number),
        record.try(:year),
        record.school.try(:rbd),
        link_to(record.school.try(:nombre), order_proccesses_path(record), :target => '_blank'),
        record.school.try(:commune).try(:name),
        record.school.try(:commune).try(:region).try(:name),
        record.school.try(:dependencia),
        record.school.try(:rut),
        record.try(:payer_type).try(:nombre),
        record.proccesses.map{|p| p.try(:proc_type).try(:nombre)},
        record.try(:contract),
        record.try(:service_type).try(:name),
        record.try(:pay_status).try(:nombre),
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Order.where.not(:number => nil).includes(
      :pay_status,:service_type,:payer_type,:school => { :commune => :region }
      )
    .references(
      :pay_status,:service_type,:payer_type,:school => { :commune => :region }
      ).distinct

  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_order_path(record)) + 
    link_to(delete_icon, order_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end

  def get_estado(record)
    facturado = record.try(:invoices).sum('invoices.monto')
    cobrado = record.try(:proccesses).sum('proccesses.monto')
    pagado = record.try(:payments).where('payments.paid = true').sum('payments.monto')

   if(cobrado == pagado)
    "PAGADO TOTAL"
    else
        if(facturado == cobrado)
            "FACTURADO TOTAL"
        else
            "EN PROCESO"
        end
   end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
