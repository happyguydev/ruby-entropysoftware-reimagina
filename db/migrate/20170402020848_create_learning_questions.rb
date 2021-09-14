class CreateLearningQuestions < ActiveRecord::Migration
  def change
    create_table :learning_questions do |t|
      t.integer :question_id
      t.integer :learning_goal_id

      t.timestamps null: false
    end
  end
end
