class UserDatatable < AjaxDatatablesRails::Base

  # or define them in one pass
  def_delegators :@view, :link_to, :h, :user_path, :edit_user_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(User.first_name User.second_name User.email UserType.name)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(User.first_name User.second_name User.email UserType.name)
  end

  private

  def data
    p records
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.first_name,
        record.second_name,
        record.email,
        record.user_type.name.capitalize,
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    User.joins(:user_type).where('user_types.role': 'admin')
  end

  def edit_and_delete_buttons record

    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, edit_user_path(record)) +
    link_to(delete_icon, user_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

  end

  # ==== Insert 'presenter'-like methods below if necessary
end
