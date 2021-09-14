class CreatePayerTypes < ActiveRecord::Migration
  def change
    create_table :payer_types do |t|
      t.string :nombre
      t.string :short_name

      t.timestamps null: false
    end
  end
end
