class ProccessInstrument < ActiveRecord::Base
	resourcify
  belongs_to :proccess
  belongs_to :instrument
  belongs_to :grade
  has_many :answers, :dependent => :delete_all
  attr_accessor :assignature
  attr_accessor :grade_level
end
