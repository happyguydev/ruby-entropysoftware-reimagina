class CreateRemedials < ActiveRecord::Migration
  def change
    create_table :remedials do |t|
      t.string :nombre
      t.references :content, index: true, foreign_key: true
      t.references :level, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
