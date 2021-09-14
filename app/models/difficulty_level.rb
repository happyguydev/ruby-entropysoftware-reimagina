class DifficultyLevel < ActiveRecord::Base
  resourcify
  has_many :questions
  auto_strip_attributes :name, :squish => true  
  validates :name, presence: true
  before_update :merge_into!

  def merge_into!
    other = DifficultyLevel.where('lower(name) = ?', self.name.try(:mb_chars).try(:downcase).try(:to_s)).where.not(id: self.id).first
    #other = Content.where(nombre: self.nombre).where(assignature_id: self.assignature_id).first
    if other.present?
      other.questions.update_all(difficulty_level_id: self.id)
      other.destroy
    end
  end
end
