class Instrument < ActiveRecord::Base
  resourcify
  has_many :proccess_instruments,:dependent => :delete_all
  has_many :proccesses, :through => :proccess_instruments
  belongs_to :evaluation
  #has_one :guide, :dependent => :destroy
  has_many :guides, :dependent => :delete_all
  has_many :instrument_questions_positions, :dependent => :delete_all
  has_many :instrument_alternatives_positions, :dependent => :delete_all
end
