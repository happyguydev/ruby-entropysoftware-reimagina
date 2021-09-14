class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :nombre
      t.string :apellido
      t.string :rut

      t.timestamps null: false
    end
  end
end
