class AddColumnCorrectToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :correct, :boolean, default: nil
  end
end
