class InstrumentQuestionsPosition < ActiveRecord::Base
  resourcify
  belongs_to :instrument
  belongs_to :question
  has_many :instrument_alternatives_positions, dependent: :destroy
end
