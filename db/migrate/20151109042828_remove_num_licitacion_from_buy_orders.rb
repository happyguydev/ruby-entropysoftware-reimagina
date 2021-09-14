class RemoveNumLicitacionFromBuyOrders < ActiveRecord::Migration
  def change
    remove_column :buy_orders, :num_licitacion, :string
  end
end
