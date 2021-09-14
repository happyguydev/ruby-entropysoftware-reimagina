class StatusType < ActiveRecord::Base
	resourcify
	has_many :orders

end
