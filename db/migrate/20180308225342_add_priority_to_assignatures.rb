class AddPriorityToAssignatures < ActiveRecord::Migration
  def change
    add_column :assignatures, :priority, :integer
  end
end
