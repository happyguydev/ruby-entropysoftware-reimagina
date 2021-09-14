class CreateInstrumentAlternativesPositions < ActiveRecord::Migration
  def change
    create_table :instrument_alternatives_positions do |t|
      t.references :instrument, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :alternative, index: true, foreign_key: true
      t.integer :instrument_questions_position_id
      t.string :position

      t.timestamps null: false
    end

    add_index :instrument_alternatives_positions, :instrument_questions_position_id, name: "instrument_questions_position_id"
  end
end
