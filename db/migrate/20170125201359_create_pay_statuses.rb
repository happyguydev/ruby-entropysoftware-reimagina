class CreatePayStatuses < ActiveRecord::Migration
  def change
    create_table :pay_statuses do |t|

      t.timestamps null: false
    end
  end
end
