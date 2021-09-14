class AddShortNameToPayStatuses < ActiveRecord::Migration
  def change
    add_column :pay_statuses, :short_name, :string
  end
end
