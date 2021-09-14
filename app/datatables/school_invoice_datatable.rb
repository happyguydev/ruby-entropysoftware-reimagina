class SchoolInvoiceDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h

  def sortable_columns
    @sortable_columns ||= %w(Invoice.numero Invoice.monto Invoice.comentario Invoice.fecha)
  end

  def searchable_columns
    @searchable_columns ||= %w(Invoice.numero Invoice.monto Invoice.comentario Invoice.fecha)
  end

  private

  def data
    records.map do |record|
      [
        record.numero,
        record.monto,
        record.comentario,
        record.fecha,
        download_invoice(record)
      ]
    end
  end

  def get_raw_records
    Invoice.where(id: options[:invoice_ids])
  end

  def download_invoice record
    link_to('<i class="fa fa-download"></i>'.html_safe,record.try(:document).url, target: "_blank")
  end

end
