class ProccessDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :order_proccess_path, :edit_order_proccess_path, :number_to_clp

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(ProcType.nombre Proccess.fecha ProcType.nombre ProcType.nombre)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(ProcType.nombre Proccess.fecha ProcType.nombre ProcType.nombre)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        link_to(record.proc_type.nombre, order_proccess_path(record.order, record)),
        record.fecha.try(:strftime, "%d/%m/%Y"),
        number_to_clp(record.try(:monto)),
        edit_and_delete_buttons(record)
      ]
    end
  end

  def get_raw_records
    # insert query here
    Order.find(options[:order_id]).proccesses.joins(:proc_type)
  end

   def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

     link_to(edit_icon, edit_order_proccess_path(record.order, record)) +
    link_to(delete_icon,  order_proccess_path(record.order, record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end

  # ==== Insert 'presenter'-like methods below if necessary
end
