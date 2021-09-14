class AddNombreToPayStatuses < ActiveRecord::Migration
  def change
    add_column :pay_statuses, :nombre, :string
  end
end
