class Grade < ActiveRecord::Base
  resourcify
  belongs_to :school
  belongs_to :level
  has_and_belongs_to_many :students
  has_and_belongs_to_many :assignatures
  has_many :proccess_instruments, :dependent => :delete_all
  
  def to_label
    "#{school.try(:nombre)} - #{level.try(:nombre)} #{letra}"
  end
  
  def add_student(student)
    #TODO: add student, dont raise if is repeated.
  end
  
end
