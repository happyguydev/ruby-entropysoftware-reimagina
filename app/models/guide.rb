class Guide < ActiveRecord::Base
  resourcify
  belongs_to :instrument
  belongs_to :question
  belongs_to :alternative
end
