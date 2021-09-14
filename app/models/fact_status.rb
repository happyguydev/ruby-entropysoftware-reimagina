class FactStatus < ActiveRecord::Base
  resourcify
  belongs_to :order
  belongs_to :fact_status_type
end
