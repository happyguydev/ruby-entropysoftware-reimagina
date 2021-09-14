class RemoveLearningGoalFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :learning_goal_id, :integer
  end
end
