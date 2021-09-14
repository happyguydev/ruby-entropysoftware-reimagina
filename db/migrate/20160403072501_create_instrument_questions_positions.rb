class CreateInstrumentQuestionsPositions < ActiveRecord::Migration
  def change
    create_table :instrument_questions_positions do |t|
      t.references :instrument, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.integer :position

      t.timestamps null: false
    end
  end
end
