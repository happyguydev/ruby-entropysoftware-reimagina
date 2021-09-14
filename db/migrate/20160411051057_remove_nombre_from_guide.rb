class RemoveNombreFromGuide < ActiveRecord::Migration
  def change
    remove_column :guides, :nombre, :string
  end
end
