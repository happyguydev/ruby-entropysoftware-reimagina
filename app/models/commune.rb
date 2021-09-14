class Commune < ActiveRecord::Base
  resourcify
  belongs_to :region
  has_many :schools
end
