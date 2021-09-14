class AddAssignatureAbilityAndAxisProgramToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :assignature_ability, index: true, foreign_key: true
    add_reference :questions, :axis_program, index: true, foreign_key: true
  end
end
