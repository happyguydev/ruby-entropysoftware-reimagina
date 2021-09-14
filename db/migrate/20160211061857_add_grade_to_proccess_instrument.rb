class AddGradeToProccessInstrument < ActiveRecord::Migration
  def change
    add_reference :proccess_instruments, :grade, index: true, foreign_key: true
  end
end
