class Answer < ActiveRecord::Base
	resourcify
  #belongs_to :evaluation
  belongs_to :proccess_instrument
  belongs_to :question
  belongs_to :student
  before_save :capitalize

  def capitalize
    self.letra = self.letra.try(:upcase).try(:strip)
  end

  
end
