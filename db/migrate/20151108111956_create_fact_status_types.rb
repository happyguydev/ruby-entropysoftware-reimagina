class CreateFactStatusTypes < ActiveRecord::Migration
  def change
    create_table :fact_status_types do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
