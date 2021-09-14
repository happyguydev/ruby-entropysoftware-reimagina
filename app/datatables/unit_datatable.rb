class UnitDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :unit_path, :edit_unit_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Unit.numero Level.nombre Assignature.nombre Unit.descripcion  )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Unit.numero Level.nombre Assignature.nombre Unit.descripcion  )
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.numero,
        record.level.nombre,
        record.assignature.nombre,
        record.descripcion,
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Unit.joins(:assignature,:level).all
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_unit_path(record)) + 
    link_to(delete_icon, unit_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
