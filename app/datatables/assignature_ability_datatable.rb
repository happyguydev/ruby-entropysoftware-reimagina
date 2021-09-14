class AssignatureAbilityDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :assignature_ability_path, :edit_assignature_ability_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Assignature.nombre AssignatureAbility.nombre AssignatureAbility.descripcion)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Assignature.nombre AssignatureAbility.nombre AssignatureAbility.descripcion)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.assignature.nombre,
        record.nombre,
        record.descripcion,
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    AssignatureAbility.joins(:assignature).all
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_assignature_ability_path(record)) + 
    link_to(delete_icon, assignature_ability_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
