class AddGroupQuestionToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :group_question, index: true, foreign_key: true
  end
end
