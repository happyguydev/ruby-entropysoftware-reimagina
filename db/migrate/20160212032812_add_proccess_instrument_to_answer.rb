class AddProccessInstrumentToAnswer < ActiveRecord::Migration
  def change
    add_reference :answers, :proccess_instrument, index: true, foreign_key: true
  end
end
