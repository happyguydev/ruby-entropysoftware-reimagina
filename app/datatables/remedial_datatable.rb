class RemedialDatatable < AjaxDatatablesRails::Base

    def_delegators :@view, :link_to, :h, :remedial_path, :edit_remedial_path

    def sortable_columns
        # Declare strings in this format: ModelName.column_name
        @sortable_columns ||= %w(Remedial.nombre Content.nombre Assignature.nombre Level.nombre)
    end

    def searchable_columns
        # Declare strings in this format: ModelName.column_name
        @searchable_columns ||= %w(Remedial.nombre Content.nombre Assignature.nombre Level.nombre)
    end

    private

    def data
        records.map do |record|
            [
                # comma separated list of the values for each cell of a table row
                # example: record.attribute,
                record.nombre,
                record.content.nombre,
                record.content.assignature.try(:nombre),
                record.level.nombre,
                edit_and_delete_buttons(record)
                ]
        end
    end

    def get_raw_records
        # insert query here
        Remedial.joins({:content => :assignature },:level).all

    end

    def edit_and_delete_buttons record

        edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
        delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

        link_to(edit_icon, edit_remedial_path(record)) + 
        link_to(delete_icon, remedial_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

    end

    # ==== Insert 'presenter'-like methods below if necessary
end
