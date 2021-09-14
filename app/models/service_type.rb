class ServiceType < ActiveRecord::Base
	has_many :orders
end
