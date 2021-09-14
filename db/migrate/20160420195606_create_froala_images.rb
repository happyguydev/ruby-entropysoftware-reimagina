class CreateFroalaImages < ActiveRecord::Migration
  def change
    create_table :froala_images do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
