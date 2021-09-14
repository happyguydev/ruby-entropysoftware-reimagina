class AddDetailsToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :rbd, :string
    add_column :schools, :dependencia, :string
    add_column :schools, :eva_nombre, :string
    add_column :schools, :eva_mail, :string
    add_column :schools, :eva_cargo, :string
    add_column :schools, :eva_telefono, :string
    add_column :schools, :resul_nombre, :string
    add_column :schools, :resul_mail, :string
    add_column :schools, :resul_cargo, :string
    add_column :schools, :resul_telefono, :string
    add_column :schools, :fact_nombre, :string
    add_column :schools, :fact_mail, :string
    add_column :schools, :fact_cargo, :string
    add_column :schools, :fact_telefono, :string
    add_column :schools, :id_comuna, :integer
  end
end
