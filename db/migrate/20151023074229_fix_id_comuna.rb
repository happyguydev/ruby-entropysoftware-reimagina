class FixIdComuna < ActiveRecord::Migration
  def change
      rename_column :schools, :id_comuna, :commune_id
  end
end
