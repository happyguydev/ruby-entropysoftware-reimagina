class AddDifficultyLevelRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :difficulty_level, index: true, foreign_key: true
  end
end
