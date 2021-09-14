class CreateAnswersAgain < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :instrument, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.string :letra
      t.timestamps null: false
    end
  end
end
