class CreateBuyOrders < ActiveRecord::Migration
  def change
    create_table :buy_orders do |t|
      t.references :order, index: true, foreign_key: true
      t.integer :monto
      t.date :fecha
      t.string :numero
      t.string :num_licitacion
      t.string :comentario

      t.timestamps null: false
    end
  end
end
