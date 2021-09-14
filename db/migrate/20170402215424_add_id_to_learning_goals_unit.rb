class AddIdToLearningGoalsUnit < ActiveRecord::Migration
  def change
    add_column :learning_goals_units, :id, :primary_key
  end
end
