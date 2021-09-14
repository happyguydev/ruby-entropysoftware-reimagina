class SchoolBillingDatatable < AjaxDatatablesRails::Base

  # or define them in one pass
  def_delegators :@view, :link_to, :h, :view_billing_order_path, :edit_user_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Payment.monto Payment.comentario Payment.fecha Payment.paid)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Payment.monto Payment.comentario Payment.fecha Payment.paid)
  end

  private

  def data
    records.map do |record|
      [
        record.monto,
        record.comentario,
        record.fecha,
        payment_status(record),
        order_detail(record)
      ]
    end
  end

  def get_raw_records
    Payment.where(id: options[:payment_ids])
  end

  def order_detail record
    link_to('<i class="fa fa-file-text"></i>'.html_safe, view_billing_order_path(payment_id: record.id), title: 'Ver detalle', remote: true)
  end

  def payment_status record
      if record.paid?
        'PAGADO'
      else
        'PENDIENTE'
      end
  end

end
