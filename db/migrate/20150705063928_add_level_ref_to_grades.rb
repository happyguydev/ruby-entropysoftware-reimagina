class AddLevelRefToGrades < ActiveRecord::Migration
  def change
    add_reference :grades, :level, index: true, foreign_key: true
  end
end
