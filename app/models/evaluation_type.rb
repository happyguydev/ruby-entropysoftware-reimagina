class EvaluationType < ActiveRecord::Base
  resourcify
  has_many :color_ranges
  
  def self.nivel_type
    where(nombre: 'NIVEL').last
  end

  def self.simce_type
    where(nombre: 'SIMCE').last
  end

  def to_label
    nombre
  end
  
end
