class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.string :nombre
      t.references :evaluation_type, index: true, foreign_key: true
      t.references :assignature, index: true, foreign_key: true
      t.references :level, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
