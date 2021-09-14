class BuyOrderDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :order_buy_order_path, :edit_order_buy_order_path,:number_to_clp

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(BuyOrder.numero BuyOrder.fecha BuyOrder.monto)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(BuyOrder.numero BuyOrder.fecha BuyOrder.monto)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.numero,
        record.try(:fecha).try(:strftime, ('%d-%m-%Y')),
        number_to_clp(record.try(:monto)),
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Order.find(options[:order_id]).buy_orders

  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_order_buy_order_path(record.order, record)) + 
    link_to(delete_icon,  order_buy_order_path(record.order, record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })+
    if record.document.present?
      link_to('<i class="fa fa-download"></i>'.html_safe,record.document.url, target: "_blank")
    end


  end
  # ==== Insert 'presenter'-like methods below if necessary
end
