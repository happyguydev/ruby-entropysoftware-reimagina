class LearningGoalsUnit < ActiveRecord::Base
	belongs_to :unit
	belongs_to :learning_goal
	accepts_nested_attributes_for :unit, :reject_if => :all_blank
	validates :description, uniqueness: { scope: [:learning_goal_id, :unit_id] }
end
