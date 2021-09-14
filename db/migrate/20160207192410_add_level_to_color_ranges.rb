class AddLevelToColorRanges < ActiveRecord::Migration
  def change
    add_reference :color_ranges, :level, index: true, foreign_key: true
  end
end
