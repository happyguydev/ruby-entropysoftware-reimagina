class AddBilledToProccesses < ActiveRecord::Migration
  def change
    add_column :proccesses, :billed, :boolean
  end
end
