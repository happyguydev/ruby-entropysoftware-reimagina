class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses do |t|
      t.integer :order_id
      t.integer :status_type_id
      t.string :comentario

      t.timestamps null: false
    end
  end
end
