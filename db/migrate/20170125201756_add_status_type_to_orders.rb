class AddStatusTypeToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :status_type, index: true, foreign_key: true
  end
end
