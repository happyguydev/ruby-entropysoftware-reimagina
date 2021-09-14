class AddNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :number, :int
  end
end
