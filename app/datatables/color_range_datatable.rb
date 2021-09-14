class ColorRangeDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :color_range_path, :edit_color_range_path
  
  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(EvaluationType.nombre Assignature.nombre Level.nombre ColorRange.nombre ColorRange.min ColorRange.max )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(EvaluationType.nombre Assignature.nombre Level.nombre ColorRange.nombre ColorRange.min ColorRange.max )
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.try(:evaluation_type).try(:nombre),
        record.try(:assignature).try(:nombre),
        record.try(:level).try(:nombre),
        record.nombre,
        record.min,
        record.max,
        square_color(record.color),
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    ColorRange.joins(:assignature,:level,:evaluation_type)
    #ColorRange.all
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_color_range_path(record)) + 
    link_to(delete_icon, color_range_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  
  
  def square_color record
    
            "<div class='input-color'>
<div class='color-box' style='background-color: "+record+";'></div>
        </div>"
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
