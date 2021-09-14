class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types do |t|
      t.string :name
      t.string :short_name

      t.timestamps null: false
    end
  end
end
