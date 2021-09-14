class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :nombre
      t.references :instrument, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :alternative, index: true, foreign_key: true
      t.integer :question_index
      t.string :alternative_index

      t.timestamps null: false
    end
  end
end
