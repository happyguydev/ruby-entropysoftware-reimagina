class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :nombre
      t.string :descripcion
      t.references :assignature, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
