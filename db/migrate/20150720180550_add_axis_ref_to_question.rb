class AddAxisRefToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :axis, index: true, foreign_key: true
  end
end
