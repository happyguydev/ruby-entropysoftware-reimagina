class AddAssignatureRefToPmeAbility < ActiveRecord::Migration
  def change
    add_reference :pme_abilities, :assignature, index: true, foreign_key: true
  end
end
