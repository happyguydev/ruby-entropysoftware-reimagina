class AxesContent < ActiveRecord::Base
	resourcify
  belongs_to :axis

  def to_label
    nombre
  end

end
