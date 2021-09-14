class AddShortNameToAssignature < ActiveRecord::Migration
  def change
    add_column :assignatures, :short_name, :string
  end
end
