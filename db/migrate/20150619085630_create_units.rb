class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.references :assignature, index: true, foreign_key: true
      t.references :level, index: true, foreign_key: true
      t.string :numero
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
