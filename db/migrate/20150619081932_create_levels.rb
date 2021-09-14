class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :nombre
      t.string :short_name
      t.timestamps null: true
    end
  end
end
