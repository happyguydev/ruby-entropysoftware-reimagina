class RemoveHasGroupQuestionFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :has_group_question, :boolean
  end
end
