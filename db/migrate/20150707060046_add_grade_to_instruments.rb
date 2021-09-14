class AddGradeToInstruments < ActiveRecord::Migration
  def change
    add_reference :instruments, :grade, index: true, foreign_key: true
  end
end
