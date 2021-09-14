class CreateAxesContents < ActiveRecord::Migration
  def change
    create_table :axes_contents do |t|
      t.references :axis, index: true, foreign_key: true
      t.string :nombre
      t.text :descripcion
      t.timestamps null: false
    end
  end
end
