class Assignature < ActiveRecord::Base
  resourcify
  has_many :axes
  has_many :pme_abilities
  has_many :contents
  has_many :axis_programs
  has_many :assignature_abilities
  has_many :color_ranges

  
  def to_label
    "#{nombre}"
  end
  
end
