class CreateFeedScores < ActiveRecord::Migration
  def change
    create_table :feed_scores do |t|
      t.string :nombre
      t.integer :score

      t.timestamps null: false
    end
  end
end
