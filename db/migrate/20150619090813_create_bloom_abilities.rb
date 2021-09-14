class CreateBloomAbilities < ActiveRecord::Migration
  def change
    create_table :bloom_abilities do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
