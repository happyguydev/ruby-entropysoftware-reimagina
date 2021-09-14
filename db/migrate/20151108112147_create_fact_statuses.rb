class CreateFactStatuses < ActiveRecord::Migration
  def change
    create_table :fact_statuses do |t|
      t.references :order, index: true, foreign_key: true
      t.references :fact_status_type, index: true, foreign_key: true
      t.string :comentario

      t.timestamps null: false
    end
  end
end
