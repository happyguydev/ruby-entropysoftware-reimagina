class AddTableProccessInstruments < ActiveRecord::Migration
  def change
    create_table :proccess_instruments do |t|
      t.integer :proccess_id
      t.integer :instrument_id
    end
  end
end
