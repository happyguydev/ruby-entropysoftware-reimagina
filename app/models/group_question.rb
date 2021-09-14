class GroupQuestion < ActiveRecord::Base
	resourcify
	has_many :questions, inverse_of: :group_question

	validates :statement, presence: true
	attr_accessor :question_ids
end
