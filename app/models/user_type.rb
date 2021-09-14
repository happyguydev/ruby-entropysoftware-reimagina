class UserType < ActiveRecord::Base
	resourcify

	has_many :users
end
