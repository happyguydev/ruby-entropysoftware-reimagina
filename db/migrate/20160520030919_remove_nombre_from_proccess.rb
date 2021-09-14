class RemoveNombreFromProccess < ActiveRecord::Migration
  def change
    remove_column :proccesses, :nombre, :string
  end
end
