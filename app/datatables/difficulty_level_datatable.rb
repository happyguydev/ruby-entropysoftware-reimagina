class DifficultyLevelDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :difficulty_level_path, :edit_difficulty_level_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(DifficultyLevel.name)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(DifficultyLevel.name)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.name,
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    DifficultyLevel.all
  end


  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_difficulty_level_path(record)) + 
    link_to(delete_icon, difficulty_level_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end

