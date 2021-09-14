class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :nombre
      t.string :rut
      t.string :direccion
      t.string :email
      t.string :telefono
      t.text :info_contacto

      t.timestamps null: false
    end
  end
end
