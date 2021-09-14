class AddProcTypeFatherRefToProcTypes < ActiveRecord::Migration
  def change
    add_reference :proc_types, :proc_type_father, index: true, foreign_key: true
  end
end
