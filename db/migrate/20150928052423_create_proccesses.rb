class CreateProccesses < ActiveRecord::Migration
  def change
    create_table :proccesses do |t|
      t.integer :order_id
      t.string :nombre
      t.integer :proc_type_id
      t.integer :monto

      t.timestamps null: false
    end
  end
end
