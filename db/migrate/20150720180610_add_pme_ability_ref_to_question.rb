class AddPmeAbilityRefToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :pme_ability, index: true, foreign_key: true
  end
end
