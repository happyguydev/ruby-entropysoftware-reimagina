class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :order, index: true, foreign_key: true
      t.string :comentario

      t.timestamps null: false
    end
  end
end
