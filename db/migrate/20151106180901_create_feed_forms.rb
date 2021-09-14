class CreateFeedForms < ActiveRecord::Migration
  def change
    create_table :feed_forms do |t|
      t.references :feedback, index: true, foreign_key: true
      t.references :feed_item, index: true, foreign_key: true
      t.references :feed_score, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
