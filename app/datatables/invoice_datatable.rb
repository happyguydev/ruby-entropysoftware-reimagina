class InvoiceDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :order_invoice_path, :edit_order_invoice_path, :toggle_approve_order_invoice_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Invoice.numero Invoice.fecha Invoice.monto)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Invoice.numero Invoice.fecha Invoice.monto)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.numero,
        record.fecha.to_date,
        record.monto,
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Order.find(options[:order_id]).invoices
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_order_invoice_path(record.order, record)) + 
    link_to(delete_icon,  order_invoice_path(record.order, record, :anchor => 'facturas'), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' }) + 
    link_to('<i class="fa fa-download"></i>'.html_safe,record.document.url, target: "_blank") +
    link_to(approve_link_text(p),toggle_approve_order_invoice_path(@order,p),:remote => true, :id => "approve_link_#{p.id}")

  end
  # ==== Insert 'presenter'-like methods below if necessary
end

