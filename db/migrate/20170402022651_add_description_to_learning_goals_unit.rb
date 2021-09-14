class AddDescriptionToLearningGoalsUnit < ActiveRecord::Migration
  def change
    add_column :learning_goals_units, :description, :string
  end
end
