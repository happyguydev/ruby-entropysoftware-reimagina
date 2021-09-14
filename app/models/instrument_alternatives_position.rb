class InstrumentAlternativesPosition < ActiveRecord::Base
  resourcify
  belongs_to :instrument
  belongs_to :question
  belongs_to :alternative
  belongs_to :instrument_questions_position
end
