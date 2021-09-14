class ProccessInstrumentDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :order_proccess_proccess_instruments_path, :edit_order_proccess_proccess_instrument_path, :proccess_id
  
  
  def initialize(vc, process_id)
    @process_id = process_id
    super(vc)
  end
  
  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(ProccessInstrument.id Assignature.nombre Level.nombre Grade.letra Instrument.nombre EvaluationType.nombre Evaluation.year)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(ProccessInstrument.id Assignature.nombre Level.nombre Grade.letra Instrument.nombre EvaluationType.nombre Evaluation.year)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        "<button class='btn btn-danger btn-remove-instrument' data-id='#{record.instrument.id}' data-nombre='#{record.instrument.nombre}'><i class='fa fa-minus'></i></button>".html_safe,
        record.instrument.evaluation.assignature.try(:nombre),
        "#{record.instrument.evaluation.level.nombre}",
        "#{record.grade.try(:letra)}",
        record.instrument.try(:nombre),
        record.instrument.evaluation.evaluation_type.nombre,
        record.instrument.evaluation.try(:year)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Proccess.find(@process_id).try(:proccess_instruments).joins(:instrument => {:evaluation => [:assignature,:level,:evaluation_type]}).joins(:grade)
  end

  # ==== Insert 'presenter'-like methods below if necessary

end
