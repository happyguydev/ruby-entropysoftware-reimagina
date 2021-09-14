class AddShortNameToStatusType < ActiveRecord::Migration
  def change
    add_column :status_types, :short_name, :string
  end
end
