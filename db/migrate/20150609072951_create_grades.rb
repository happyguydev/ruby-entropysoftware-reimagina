class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :school_id
      t.string :grado
      t.string :letra
      t.integer :year

      t.timestamps null: false
    end
  end
end
