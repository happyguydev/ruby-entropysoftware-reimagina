class AxisDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :axis_path, :edit_axis_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Axis.nombre Assignature.nombre Axis.descripcion )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Axis.nombre Assignature.nombre Axis.descripcion )
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,

        # Nombre del eje es un link al contenido del eje que no va por el momento
        # link_to(record.nombre, axis_path(record)),

        record.nombre,
        record.assignature.try(:nombre),
        record.descripcion,
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Axis.joins(:assignature).all
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_axis_path(record)) + 
    link_to(delete_icon, axis_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end

  # ==== Insert 'presenter'-like methods below if necessary
end
