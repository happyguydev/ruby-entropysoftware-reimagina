class AddFechaToProccesses < ActiveRecord::Migration
  def change
    add_column :proccesses, :fecha, :date
  end
end
