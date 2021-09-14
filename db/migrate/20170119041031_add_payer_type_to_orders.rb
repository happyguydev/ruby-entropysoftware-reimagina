class AddPayerTypeToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :payer_type, index: true, foreign_key: true
  end
end
