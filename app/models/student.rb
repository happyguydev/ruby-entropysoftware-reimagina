class Student < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :grades
  validates_presence_of :rut
  has_many :answers
  
  validates :nombre, :apellido, presence: true
end
