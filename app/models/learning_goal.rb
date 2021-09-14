class LearningGoal < ActiveRecord::Base
  resourcify
  #has_and_belongs_to_many :questions
  has_many :learning_questions
  has_many :questions, :through => :learning_questions
  belongs_to :assignature
  belongs_to :level
  #has_and_belongs_to_many :units
  has_many :learning_goals_units, :dependent => :delete_all
  has_many :units, :through => :learning_goals_units
  #valido que en una misma asignatura y mismo curso solo puede haber 1 OA con el mismo nombre
  validates :nombre, :level_id, :assignature_id, presence: true
  validates :nombre, uniqueness: { scope: [:level_id, :assignature_id] }
  #dependencias cocoon
  accepts_nested_attributes_for :units
  accepts_nested_attributes_for :learning_goals_units, allow_destroy: true
  
  def to_label
    nombre
  end
  
end
