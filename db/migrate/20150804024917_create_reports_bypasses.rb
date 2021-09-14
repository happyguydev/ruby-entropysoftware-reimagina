class CreateReportsBypasses < ActiveRecord::Migration
  def change
    create_table :reports_bypasses do |t|
      t.string :nombre
      t.attachment :report

      t.timestamps null: false
    end
  end
end
