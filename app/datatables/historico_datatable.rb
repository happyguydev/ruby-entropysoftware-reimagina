class HistoricoDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :order_path, :edit_order_path, :order_proccesses_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number'

      ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
      'Order.number',
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
        record.school.try(:commune).try(:region).try(:roman),
        record.school.try(:dependencia),
        record.school.try(:rut),
        "Pagador",
        record.proccesses.map{|p| p.proc_type.nombre},
        record.try(:contract),
        record.try(:service_type).try(:name),
        record.order_statuses.try(:last).try(:status_type).try(:nombre),
        ]
    end
  end

  def get_raw_records
    # insert query here
    Order.includes(
      :school => { :commune => :region }, :order_statuses => :status_type
      )
    .references(
      :school => { :commune => :region }, :order_statuses => :status_type
      ).distinct

  end


  # ==== Insert 'presenter'-like methods below if necessary
end
