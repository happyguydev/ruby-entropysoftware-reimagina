class AddAssignatureRefToAxes < ActiveRecord::Migration
  def change
    add_reference :axes, :assignature, index: true, foreign_key: true
  end
end
