class AddYearToEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :year, :integer
  end
end
