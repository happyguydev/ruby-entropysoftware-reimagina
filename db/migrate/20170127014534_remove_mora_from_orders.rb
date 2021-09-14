class RemoveMoraFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :mora, :integer
  end
end
