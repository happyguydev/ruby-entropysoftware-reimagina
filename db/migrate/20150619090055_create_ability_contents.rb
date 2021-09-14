class CreateAbilityContents < ActiveRecord::Migration
  def change
    create_table :ability_contents do |t|
      t.references :pme_ability, index: true, foreign_key: true
      t.string :nombre
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
