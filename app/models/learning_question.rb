class LearningQuestion < ActiveRecord::Base

	belongs_to :question
	belongs_to :learning_goal 
end
