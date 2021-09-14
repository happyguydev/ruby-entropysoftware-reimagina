class CreateProcTypeFathers < ActiveRecord::Migration
  def change
    create_table :proc_type_fathers do |t|
      t.string :nombre
      t.string :short_name

      t.timestamps null: false
    end
  end
end
