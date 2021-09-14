class Alternative < ActiveRecord::Base
	resourcify
  belongs_to :question
	has_many :instrument_alternatives_positions, :dependent => :destroy
	has_many :guides, :dependent => :destroy
	default_scope { order('id') } 
end
