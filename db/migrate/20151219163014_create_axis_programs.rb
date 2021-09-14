class CreateAxisPrograms < ActiveRecord::Migration
  def change
    create_table :axis_programs do |t|
      t.string :nombre
      t.text :descripcion
      t.references :assignature, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
