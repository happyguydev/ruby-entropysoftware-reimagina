class CreateJoinTableEvaluationsQuestions < ActiveRecord::Migration
  def change
    create_join_table :evaluations, :questions do |t|
      # t.index [:evaluation_id, :question_id]
      # t.index [:question_id, :evaluation_id]
    end
  end
end
