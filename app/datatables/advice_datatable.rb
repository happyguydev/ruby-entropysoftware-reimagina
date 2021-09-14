class AdviceDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :advice_path, :edit_advice_path


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Advice.name Assignature.nombre Level.nombre )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Advice.name Assignature.nombre Level.nombre )
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.name,
        record.try(:questions).try(:first).try(:assignature).try(:nombre),
        record.try(:questions).try(:first).try(:level).try(:nombre),
        edit_and_delete_buttons(record)

      ]
    end
  end

  def get_raw_records
    # insert query here
    Advice.includes(:questions => [:assignature,:level]).references(:questions => [:assignature,:level]).distinct
  end

  # ==== Insert 'presenter'-like methods below if necessary

    def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_advice_path(record)) + 
    link_to(delete_icon, advice_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
end
