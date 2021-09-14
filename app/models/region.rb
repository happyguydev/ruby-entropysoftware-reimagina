class Region < ActiveRecord::Base
	resourcify
      has_many :communes

end
