class FacturaDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :order_invoice_path, :edit_order_invoice_path, :toggle_approve_order_invoice_path, :number_to_clp

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Order.year Invoice.fecha Invoice.monto Invoice.numero Invoice.fecha Invoice.monto Invoice.fecha Invoice.paid)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Order.year Invoice.fecha Invoice.monto Invoice.numero Invoice.fecha Invoice.monto Invoice.fecha Invoice.paid)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.try(:order).try(:year),        
        record.try(:order).try(:school).try(:nombre),
        record.try(:order).try(:school).try(:commune).try(:name),
        record.try(:order).try(:school).try(:commune).try(:region).try(:roman),
        record.try(:numero),
        number_to_clp(record.try(:monto)),
        record.try(:fecha).try(:strftime, ('%d-%m-%Y')),
        get_estado(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Invoice.joins(:order).all
  end

  def get_estado(record)
    if record.paid == nil 
      "Sin estado"
      else
      record.paid? ? "Pagada" : "No pagada"
    end
  end
end
