class CreateAssignatures < ActiveRecord::Migration
  def change
    create_table :assignatures do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
