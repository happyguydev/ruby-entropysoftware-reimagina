class AddAttachmentDocumentToBuyOrders < ActiveRecord::Migration
  def self.up
    change_table :buy_orders do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :buy_orders, :document
  end
end
