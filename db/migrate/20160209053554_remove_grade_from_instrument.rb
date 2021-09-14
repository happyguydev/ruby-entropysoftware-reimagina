class RemoveGradeFromInstrument < ActiveRecord::Migration
  def change
    remove_reference :instruments, :grade, index: true, foreign_key: true
  end
end
