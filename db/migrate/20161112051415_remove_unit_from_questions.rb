class RemoveUnitFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :unit_id, :integer
  end
end
