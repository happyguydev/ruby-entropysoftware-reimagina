class ChangeFechaInInvoices < ActiveRecord::Migration
  
  def self.up
    change_column :invoices, :fecha, :date
  end
 
  def self.down
    change_column :invoices, :fecha, :datetime
  end
  
end
