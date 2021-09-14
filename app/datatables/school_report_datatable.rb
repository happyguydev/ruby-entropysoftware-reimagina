class SchoolReportDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :proccess_instrument_answers_path, :results_report_proccess_instrument_path, 
  :instrument_path, :destroy_answers_proccess_instrument_path,:results_report_pdf_proccess_instrument_path, 
  :instrument_path, :results_generate_report_pdf_proccess_instrument_path, :results_download_pdf_proccess_instrument_path, :current_user
  
  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    #@sortable_columns ||= %w(School.nombre Instrument.nombre ProccessType.nombre)
    @sortable_columns ||= %w(Order.year School.nombre Level.nombre Grade.letra Assignature.nombre ProcType.nombre)

  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    # @searchable_columns ||= %w(School.nombre Instrument.nombre ProccessType.nombre)
    @searchable_columns ||= %w(Order.year School.nombre Level.nombre Grade.letra Assignature.nombre ProcType.nombre)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.proccess.order.year,
        record.proccess.order.school.nombre,
        "#{record.instrument.evaluation.level.nombre}",
        "#{record.grade.try(:letra)}",
        record.instrument.evaluation.assignature.nombre,
        record.proccess.proc_type.try(:nombre),
        options_buttons(record)
        ]
    end
  end

  def get_raw_records
    ProccessInstrument.joins(proccess: [{:order => :school}, :proc_type]).joins(instrument: {:evaluation => [:assignature,:level]}).joins(:grade).where('schools.id': options[:school_id])
  end

  def options_buttons record
    opc_string = ""
    if record.proccess.order.can_download? && record.proccess.fecha <= DateTime.now && record.answers.count == 0
      opc_string = link_to('<i class="fa fa-check-circle" aria-hidden="true"></i>'.html_safe, proccess_instrument_answers_path(record), title: 'Enviar respuestas de evaluación!')
      # opc_string = link_to( '<i class="fa fa-check-circle" aria-hidden="true"></i>'.html_safe, proccess_instrument_answers_path(record))
    else
      #opc_string = link_to('<i class="fa fa-download"></i>'.html_safe,results_report_pdf_proccess_instrument_path(record), target: "_blank", title: 'Descargar informe')
       opc_string =
      (record.report_generated ? link_to( '<i class="fa fa-download" aria-hidden="true"></i>'.html_safe, results_download_pdf_proccess_instrument_path(record)) : '')
      #link_to( '<i class="fa fa-bar-chart-o" aria-hidden="true"></i>'.html_safe, results_report_proccess_instrument_path(record))+" "+
    end
  end
  # ==== Insert 'presenter'-like methods below if necessary
end
