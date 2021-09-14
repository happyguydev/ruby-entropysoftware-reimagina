class AddPaydateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :paydate, :date
  end
end
