class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :roman

      t.timestamps null: false
    end
  end
end
