class CreateAdvices < ActiveRecord::Migration
  def change
    create_table :advices do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
