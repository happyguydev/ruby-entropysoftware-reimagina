class InstrumentsByOrderDatatable < AjaxDatatablesRails::Base

  def initialize(vc, process_id)
    @process_id = process_id
    super(vc)
  end

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Instrument.id Assignature.nombre Level.nombre Instrument.nombre EvaluationType.nombre Evaluation.year)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||=  %w(Instrument.id Assignature.nombre Level.nombre Instrument.nombre EvaluationType.nombre Evaluation.year)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        "<button class='btn btn-primary btn-add-instrument' data-id='#{record.id}' data-nombre='#{record.nombre}'><i class='fa fa-plus'></i></button>".html_safe,
        record.evaluation.assignature.nombre,
        record.evaluation.level.nombre,
        record.try(:nombre),
        record.evaluation.try(:evaluation_type).nombre,
        record.evaluation.try(:year)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Instrument.joins(:evaluation => [:assignature,:level,:evaluation_type])
    #Instrument.where(grade_id: Order.find(options[:order_id]).school.grade_ids)
    #Instrument.joins(:evaluation => [:assignature,:level]).where(level_id: Order.find(options[:order_id]).school.grades.pluck(:level_id).uniq)

  end

  # ==== Insert 'presenter'-like methods below if necessary
end
