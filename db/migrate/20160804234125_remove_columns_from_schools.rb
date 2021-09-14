class RemoveColumnsFromSchools < ActiveRecord::Migration
  def change
    remove_column :schools, :eva_nombre, :string
    remove_column :schools, :eva_mail, :string
    remove_column :schools, :eva_cargo, :string
    remove_column :schools, :eva_telefono, :string
    remove_column :schools, :resul_nombre, :string
    remove_column :schools, :resul_mail, :string
    remove_column :schools, :resul_cargo, :string
    remove_column :schools, :resul_telefono, :string
    remove_column :schools, :fact_nombre, :string
    remove_column :schools, :fact_mail, :string
    remove_column :schools, :fact_cargo, :string
    remove_column :schools, :fact_telefono, :string
  end
end
