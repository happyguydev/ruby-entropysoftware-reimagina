class AddMoraToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :mora, :integer
  end
end
