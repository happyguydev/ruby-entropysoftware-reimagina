class Unit < ActiveRecord::Base
	resourcify
  belongs_to :assignature
  belongs_to :level
  belongs_to :content
  #has_and_belongs_to_many :learning_goals
  has_many :learning_goals_units
  has_many :learning_goals, :through => :learning_goals_units, :dependent => :delete_all
	has_and_belongs_to_many :questions
  
	validates :numero, :level_id, :assignature_id, presence: true

  def to_label
    numero
  end
  
  
end
