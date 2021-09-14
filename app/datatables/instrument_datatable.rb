class InstrumentDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :instrument_path, :edit_instrument_path, :guide_instrument_path, :mass_evelution_edit_questions_path, :mass_remedials_instrument_path


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Evaluation.year EvaluationType.nombre Instrument.nombre Assignature.nombre Level.nombre)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Evaluation.year EvaluationType.nombre Instrument.nombre Assignature.nombre Level.nombre)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.evaluation.try(:year),
        record.evaluation.evaluation_type.try(:nombre),
        record.try(:nombre),
        record.try(:evaluation).try(:assignature).try(:nombre),
        record.evaluation.try(:level).try(:nombre),
        edit_and_delete_buttons(record)

        ]
    end
  end

  def get_raw_records
    # insert query here
    #Instrument.includes(:evaluation => [:assignature,:level]).distinct
    #Instrument.joins(:evaluation => [:assignature,:level]).all

    Instrument.includes(
      :evaluation => [:assignature,:level, :evaluation_type])
    .references(
      :evaluation => [:assignature,:level,:evaluation_type]
      ).distinct

  end

  def edit_and_delete_buttons record
    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to('<i class="fa fa-eye"></i>'.html_safe,instrument_path(record), target: "_blank", title: 'Ver evaluación') +
    link_to('<i class="fa fa-pencil"></i>'.html_safe,edit_instrument_path(record), target: "_blank", title: 'Editar evaluación') +
    link_to('<i class="fa fa-download"></i>'.html_safe,instrument_path(record, format: :pdf), target: "_blank", title: 'Descarga evaluación') +
    link_to('<i class="fa fa-check"></i>'.html_safe, guide_instrument_path(record),target: "_blank", title: 'Ver pauta de respuestas') +
    # link_to('<i class="fa fa-th"></i>'.html_safe, mass_evelution_edit_questions_path(id:record, all_questions_ids: record.instrument_alternatives_positions.order('position ASC').collect(&:question).uniq), :onclick=>"$('#overlay, #please-wait').show();", remote: true, title: 'Edición masiva') +
    link_to('<i class="fa fa-th"></i>'.html_safe, mass_evelution_edit_questions_path(id:record), :onclick=>"$('#overlay, #please-wait').show();", remote: true, title: 'Edición masiva')+
    link_to('<i class="fa fa-refresh"></i>'.html_safe, mass_remedials_instrument_path(record), title: 'Ingreso masivo Remediales')+
    if record.evaluation.pdfguide.present?
        link_to('<i class="fa fa-info-circle"></i>'.html_safe,record.evaluation.pdfguide.url, target: "_blank", title: 'Bajar guia en PDF')
    end

    # link_to('EM', mass_evelution_edit_questions_path(id:record), remote: true)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
