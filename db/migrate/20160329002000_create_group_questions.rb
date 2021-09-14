class CreateGroupQuestions < ActiveRecord::Migration
  def change
    create_table :group_questions do |t|
      t.text :statement

      t.timestamps null: false
    end

    create_table :group_questions_questions, id: false do |t|
      t.belongs_to :group_question, index: true
      t.belongs_to :question, index: true
    end
  end
end
