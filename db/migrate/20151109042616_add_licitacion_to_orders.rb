class AddLicitacionToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :licitacion, :string
  end
end
