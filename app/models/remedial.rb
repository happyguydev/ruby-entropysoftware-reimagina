class Remedial < ActiveRecord::Base
	resourcify
	
  belongs_to :content
  belongs_to :level
  attr_accessor :assignature

  validates :nombre, :level_id, :content_id, presence: true
end
