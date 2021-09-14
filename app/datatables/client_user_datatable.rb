class ClientUserDatatable < AjaxDatatablesRails::Base

  # or define them in one pass
  def_delegators :@view, :link_to, :h, :user_path, :edit_user_path, :update_client_user_users_path

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
        assigned_school_list(record) + assign_link(record),
        edit_and_delete_buttons(record)
        ]
    end
  end

  def get_raw_records
    # insert query here
    User.joins(:user_type).where('user_types.role': 'client')
  end

  def assign_link record
    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    link_to(edit_icon, '/admin/assigned_schools/assign?user_id='+record.try(:id).to_s, title: 'Asignar establecimiento', remote: true, class: 'assign-school')
  end

  def assigned_school_list record
    assigned = record.assigned_schools.try(:count)
    case assigned
      when 0
      'Sin establecimiento asignado'
      when 1
        school = record.assigned_schools.try(:first).try(:school)
        link_to(school.try(:nombre), '/schools/'+school.try(:id).to_s)
      else
      link_to('Establecimientos asignados', '/admin/assigned_schools/assigned?user_id='+record.try(:id).to_s, remote: true)
      end
  end

  def edit_and_delete_buttons record
    edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
    delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

    link_to(edit_icon, update_client_user_users_path(id: record.id)) +
    link_to(delete_icon, user_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
