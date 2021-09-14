class AddAssignatureToAssignatureAbility < ActiveRecord::Migration
  def change
    add_reference :assignature_abilities, :assignature, index: true, foreign_key: true
  end
end
