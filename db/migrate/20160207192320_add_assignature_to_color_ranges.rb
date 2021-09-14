class AddAssignatureToColorRanges < ActiveRecord::Migration
  def change
    add_reference :color_ranges, :assignature, index: true, foreign_key: true
  end
end
