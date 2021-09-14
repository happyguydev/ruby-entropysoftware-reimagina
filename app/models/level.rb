class Level < ActiveRecord::Base
  resourcify
  has_many :grades
  has_many :color_ranges
  
  def to_label
    nombre
  end
  
end
