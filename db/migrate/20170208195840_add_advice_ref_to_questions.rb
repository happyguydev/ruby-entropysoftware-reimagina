class AddAdviceRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :advice, index: true, foreign_key: true
  end
end
