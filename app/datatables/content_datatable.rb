class ContentDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :content_path, :edit_content_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Content.nombre Assignature.nombre)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Content.nombre Assignature.nombre)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.nombre,
        record.assignature.try(:nombre),
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    Content.joins(:assignature).all
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_content_path(record)) + 
    link_to(delete_icon, content_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
