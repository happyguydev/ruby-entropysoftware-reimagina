class AddPayStatusToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :pay_status, index: true, foreign_key: true
  end
end
