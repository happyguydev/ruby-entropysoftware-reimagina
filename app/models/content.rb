class Content < ActiveRecord::Base
  resourcify
  belongs_to :assignature
  has_many :questions
  has_many :remedials
  auto_strip_attributes :nombre, :squish => true  
  validates :nombre, uniqueness: { scope: [:assignature_id], :case_sensitive => false}, on: :create
  validates :nombre, :assignature_id, presence: true
  before_update :merge_into!

  def to_label
    nombre
  end

   def merge_into!
    other = Content.where('lower(nombre) = ? AND assignature_id = ? ', self.nombre.try(:mb_chars).try(:downcase).try(:to_s), self.assignature.id).where.not(id: self.id).first
    #other = Content.where(nombre: self.nombre).where(assignature_id: self.assignature_id).first
    if other.present?
      other.questions.update_all(content_id: self.id)
      other.destroy
    end
  end
end
