class SchoolDatatable < AjaxDatatablesRails::Base

  # or define them in one pass
  def_delegators :@view, :link_to, :h, :school_path, :edit_school_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(School.rbd School.nombre Commune.name Region.roman School.dependencia School.telefono School.email)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||=  %w(School.rbd School.nombre Commune.name Region.roman School.dependencia School.telefono School.email)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.try(:rbd),
        link_to(record.nombre,school_path(record)),
        record.commune.try(:name),
        record.commune.try(:region).try(:name),
        record.try(:dependencia),
        record.try(:telefono),
        record.try(:email), 
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    #School.includes( :commune => :region )
    School.joins(:commune => :region)
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_school_path(record)) + 
    link_to(delete_icon, school_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end
  # ==== Insert 'presenter'-like methods below if necessary
end
