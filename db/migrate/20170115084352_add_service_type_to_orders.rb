class AddServiceTypeToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :service_type, index: true, foreign_key: true
  end
end
