class AddCanDownloadToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :can_download, :boolean, default: true
  end
end
