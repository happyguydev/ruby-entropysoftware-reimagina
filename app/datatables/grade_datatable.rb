class GradeDatatable < AjaxDatatablesRails::Base

  # or define them in one pass
  def_delegators :@view, :link_to, :h, :school_grade_path, :edit_school_grade_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Level.id Grade.year Grade.year Grade.year)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Level.id Grade.year Grade.year Grade.year )
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,

        link_to( "#{record.level.nombre} #{record.try(:letra)}", school_grade_path(record.school, record)),
        record.year,
        record.try(:students).try(:count),
        edit_and_delete_buttons(record)

        ]
    end
  end

  def get_raw_records
    # insert query here
    School.find(options[:school_id]).grades.joins(:level)
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_school_grade_path(record.school, record)) +
    link_to(delete_icon,  school_grade_path(record.school, record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
