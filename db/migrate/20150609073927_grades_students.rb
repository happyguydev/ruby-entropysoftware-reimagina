class GradesStudents < ActiveRecord::Migration
  def change
    create_join_table :grades, :students
  end
end
