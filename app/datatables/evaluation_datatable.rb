class EvaluationDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :evaluation_path, :edit_evaluation_path, :mass_evelution_edit_questions_path

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
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.try(:year),
        record.try(:nombre),
        record.evaluation_type.try(:nombre),
        record.assignature.try(:nombre),
        record.level.try(:nombre),
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Evaluation.joins(:evaluation_type,:assignature,:level).all
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe
    show_icon = '<i class="fa fa-eye"></i>'.html_safe
    index_icon = '<i class="fa fa-eye"></i>'.html_safe
    # show_icon1 = 'Question'.html_safe

    link_to(show_icon, evaluation_path(record)) +
    link_to(edit_icon, edit_evaluation_path(record)) +
    link_to(delete_icon, evaluation_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' }) +
    if record.pdfguide.present?
        link_to('<i class="fa fa-info-circle"></i>'.html_safe,record.pdfguide.url, target: "_blank")
    end
    # link_to('EM', mass_evelution_edit_questions_path(id:record, all_questions_ids: record.questions.collect(&:id)), remote: true)
    
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
