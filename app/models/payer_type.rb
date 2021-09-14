class PayerType < ActiveRecord::Base
		has_many :orders
end
