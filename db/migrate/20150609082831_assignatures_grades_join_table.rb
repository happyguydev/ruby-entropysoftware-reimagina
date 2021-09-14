class AssignaturesGradesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :assignatures, :grades
  end
end
