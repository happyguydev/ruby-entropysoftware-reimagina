class CreateAxes < ActiveRecord::Migration
  def change
    create_table :axes do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
