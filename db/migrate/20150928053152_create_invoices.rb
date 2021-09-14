class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :order_id
      t.integer :numero
      t.datetime :fecha
      t.integer :monto

      t.timestamps null: false
    end
  end
end
