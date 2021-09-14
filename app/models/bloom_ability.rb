class BloomAbility < ActiveRecord::Base

  resourcify
  has_many :questions
  auto_strip_attributes :nombre, :squish => true  
  validates :nombre, presence: true
  before_update :merge_into!

  def to_label
    nombre
  end
  def merge_into!
    other = BloomAbility.where('lower(nombre) = ?', self.nombre.try(:mb_chars).try(:downcase).try(:to_s)).where.not(id: self.id).first
    #other = Content.where(nombre: self.nombre).where(assignature_id: self.assignature_id).first
    if other.present?
      other.questions.update_all(bloom_ability_id: self.id)
      other.destroy
    end
  end
end
