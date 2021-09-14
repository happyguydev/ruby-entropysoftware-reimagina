class AxisProgramDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :axis_program_path, :edit_axis_program_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(AxisProgram.nombre Assignature.nombre AxisProgram.descripcion )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(AxisProgram.nombre Assignature.nombre AxisProgram.descripcion )
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.nombre,
        record.assignature.try(:nombre),
        record.descripcion,
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    AxisProgram.joins(:assignature).all
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_axis_program_path(record)) +
    link_to(delete_icon, axis_program_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
