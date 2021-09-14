class ChangeFechaInPayments < ActiveRecord::Migration
  def self.up
    change_column :payments, :fecha, :date
  end
 
  def self.down
    change_column :payments, :fecha, :datetime
  end
end
