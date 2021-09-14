class ProcTypeDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :proc_type_path, :edit_proc_type_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(ProcType.nombre ProcTypeFather.nombre ProcType.priority)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(ProcType.nombre ProcTypeFather.nombre ProcType.priority)
  end

  private

  def data
    records.map do |record|
      [
        record.try(:nombre),
        record.try(:proc_type_father).try(:nombre),
        record.try(:priority),
        edit_and_delete_buttons(record)
      ]
    end
  end

  def get_raw_records
    ProcType.includes(:proc_type_father).references(:proc_type_father).distinct
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_proc_type_path(record)) +
    link_to(delete_icon,  proc_type_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
