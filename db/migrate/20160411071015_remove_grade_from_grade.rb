class RemoveGradeFromGrade < ActiveRecord::Migration
  def change
    remove_column :grades, :grado, :string
  end
end
