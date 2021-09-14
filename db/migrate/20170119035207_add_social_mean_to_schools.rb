class AddSocialMeanToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :socialmean, :string
  end
end
