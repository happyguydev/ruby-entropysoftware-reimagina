class AddContentRefToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :content, index: true, foreign_key: true
  end
end
