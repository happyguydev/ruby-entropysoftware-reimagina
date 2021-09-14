class AddPriorityToProcTypes < ActiveRecord::Migration
  def change
    add_column :proc_types, :priority, :integer
  end
end
