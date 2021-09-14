class SchoolEvaluationDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :proccess_instrument_answers_path, :results_report_proccess_instrument_path, :instrument_path,:results_report_pdf_proccess_instrument_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Evaluation.year Evaluation.nombre EvaluationType.nombre Assignature.nombre Level.nombre)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Evaluation.year Evaluation.nombre EvaluationType.nombre Assignature.nombre Level.nombre)
  end

  private

  def data
    records.map do |record|
      [
        record.try(:instrument).try(:evaluation).try(:year),
        record.try(:instrument).try(:evaluation).try(:nombre),
        record.try(:instrument).try(:evaluation).try(:evaluation_type).try(:nombre),
        record.try(:instrument).try(:evaluation).try(:assignature).try(:nombre),
        record.try(:grade).try(:level).try(:nombre),
        edit_and_delete_buttons(record)
      ]
    end
  end

  def get_raw_records
    ProccessInstrument.joins(proccess: {:order => :school}).joins(instrument: {:evaluation => [:assignature,:level]}).joins(:grade).where('schools.id': options[:school_id], 'grades.school_id': options[:school_id])
  end

  def edit_and_delete_buttons record
      if record.proccess.order.can_download? && record.proccess.fecha <= DateTime.now && record.answers.count == 0
       (link_to('<i class="fa fa-download"></i>'.html_safe, instrument_path(record.try(:instrument), format: :pdf), target: "_blank", title: 'Descargar evaluacion en PDF')) +
           if record.instrument.evaluation.pdfguide.present?
             link_to('<i class="fa fa-info-circle"></i>'.html_safe,record.instrument.evaluation.pdfguide.url, target: "_blank", title: 'Descargar guía en PDF')
           end
     end
  end
end