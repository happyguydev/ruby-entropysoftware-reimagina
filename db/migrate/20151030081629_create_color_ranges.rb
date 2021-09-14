class CreateColorRanges < ActiveRecord::Migration
  def change
    create_table :color_ranges do |t|
      t.string :nombre
      t.integer :min
      t.integer :max
      t.string :color
      t.references :evaluation_type, index: true, foreign_key: true
      t.string :simce_range

      t.timestamps null: false
    end
  end
end
