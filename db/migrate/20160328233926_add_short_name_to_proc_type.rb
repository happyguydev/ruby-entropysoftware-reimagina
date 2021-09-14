class AddShortNameToProcType < ActiveRecord::Migration
  def change
    add_column :proc_types, :short_name, :string
  end
end
