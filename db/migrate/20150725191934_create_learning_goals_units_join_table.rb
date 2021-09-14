class CreateLearningGoalsUnitsJoinTable < ActiveRecord::Migration
  def change
    create_table :learning_goals_units, id: false do |t|
      t.integer :learning_goal_id
      t.integer :unit_id
    end
    add_index :learning_goals_units, :learning_goal_id
    add_index :learning_goals_units, :unit_id
  end
end
