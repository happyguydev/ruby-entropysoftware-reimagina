class RemoveSimceRangeFromColorRange < ActiveRecord::Migration
  def change
    remove_column :color_ranges, :simce_range, :string
  end
end
