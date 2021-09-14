class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :school_id
      t.integer :year
      t.string :paymethod
      t.string :contract

      t.timestamps null: false
    end
  end
end
