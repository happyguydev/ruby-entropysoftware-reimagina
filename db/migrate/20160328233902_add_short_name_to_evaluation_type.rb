class AddShortNameToEvaluationType < ActiveRecord::Migration
  def change
    add_column :evaluation_types, :short_name, :string
  end
end
