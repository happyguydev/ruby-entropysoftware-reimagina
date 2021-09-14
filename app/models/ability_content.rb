class AbilityContent < ActiveRecord::Base
	resourcify
  belongs_to :pme_ability
  
  def to_label
    nombre
  end
  
end
