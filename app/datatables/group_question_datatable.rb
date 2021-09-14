class GroupQuestionDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :group_question_path, :edit_group_question_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(GroupQuestion.id GroupQuestion.statement)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(GroupQuestion.id GroupQuestion.statement)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.id,
        link_to(record.statement.html_safe, group_question_path(record)),
        record.questions.try(:count),
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    GroupQuestion.all
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe
    
    link_to(edit_icon, edit_group_question_path(record), remote: true) + 
    link_to(delete_icon, group_question_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end

  # ==== Insert 'presenter'-like methods below if necessary
end