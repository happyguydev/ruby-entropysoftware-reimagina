class AddHasGroupQuestionToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :has_group_question, :boolean, null: false, default: false
  end
end
