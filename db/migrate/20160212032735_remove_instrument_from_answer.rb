class RemoveInstrumentFromAnswer < ActiveRecord::Migration
  def change
    remove_reference :answers, :instrument, index: true, foreign_key: true
  end
end
