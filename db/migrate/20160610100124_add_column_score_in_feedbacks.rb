class AddColumnScoreInFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :score, :integer, default: 0
  end
end
