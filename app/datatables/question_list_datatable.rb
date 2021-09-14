class QuestionListDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :question_path, :edit_question_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Question.texto Assignature.nombre Level.nombre Content.nombre BloomAbility.nombre AssignatureAbility.nombre Axis.nombre AxisProgram.nombre PmeAbility.nombre DifficultyLevel.name Question.group_question_id)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Question.texto Assignature.nombre Level.nombre Content.nombre BloomAbility.nombre AssignatureAbility.nombre Axis.nombre AxisProgram.nombre PmeAbility.nombre DifficultyLevel.name Question.group_question_id)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        link_to(record.try(:texto).html_safe, question_path(record)),
        record.assignature.try(:nombre),
        record.level.try(:nombre),
        record.content.try(:nombre),
        record.bloom_ability.try(:nombre),
        record.assignature_ability.try(:nombre),
        record.axis.try(:nombre),
        record.axis_program.try(:nombre),
        record.pme_ability.try(:nombre),
        record.difficulty_level.try(:name),
        record.try(:group_question_id),
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
   Question.includes(:assignature,:level,:content,:bloom_ability,:assignature_ability,:axis,:axis_program, :pme_ability,:difficulty_level).references(:question).distinct
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe
    show_icon = '<i class="fa fa-eye"></i>'.html_safe

    link_to(show_icon, question_path(record)) +
    link_to(edit_icon, edit_question_path(record)) +
    link_to(delete_icon, question_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
