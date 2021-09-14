class StudentDatatable < AjaxDatatablesRails::Base

  # or define them in one pass
  def_delegators :@view, :link_to, :h, :grade_student_path, :edit_grade_student_path


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Student.rut Student.nombre Student.apellido)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Student.rut Student.nombre Student.apellido)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.rut,
        record.nombre,
        record.apellido,
        edit_and_delete_buttons(record)

        ]
    end
  end

  def get_raw_records
    # insert query here
    Grade.find(options[:grade_id]).students
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_grade_student_path(record.grades.last, record)) + 
    link_to(delete_icon,  grade_student_path(record.grades.last, record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
