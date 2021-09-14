class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
