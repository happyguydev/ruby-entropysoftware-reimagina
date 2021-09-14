class Advice < ActiveRecord::Base
  resourcify
  has_many :questions
  auto_strip_attributes :name, :squish => true  
  validates :name,:uniqueness => true, on: :create
  validates :name,presence: true
  before_update :merge_into!

    def merge_into!
    other = Advice.where('lower(name) = ?', self.name.try(:mb_chars).try(:downcase).try(:to_s)).where.not(id: self.id).first
    #other = Content.where(nombre: self.nombre).where(assignature_id: self.assignature_id).first
    if other.present?
      other.questions.update_all(advice_id: self.id)
      other.destroy
    end
  end
end
