class CreateLearningGoals < ActiveRecord::Migration
  def change
    create_table :learning_goals do |t|
      t.string :nombre
      t.text :descripcion
      t.references :assignature, index: true, foreign_key: true
      t.references :level, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
