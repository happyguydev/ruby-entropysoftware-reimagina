class CreateJoinTableQuestionUnit < ActiveRecord::Migration
  def change
    create_join_table :questions, :units do |t|
      # t.index [:question_id, :unit_id]
      # t.index [:unit_id, :question_id]
    end
  end
end
