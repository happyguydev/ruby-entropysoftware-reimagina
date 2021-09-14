class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.string :nombre
      t.references :evaluation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
