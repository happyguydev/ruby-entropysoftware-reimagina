class RemoveDescripcionFromLearningGoals < ActiveRecord::Migration
  def change
    remove_column :learning_goals, :descripcion, :string
  end
end
