class ColorRange < ActiveRecord::Base
  resourcify
  belongs_to :evaluation_type
  belongs_to :assignature
  belongs_to :level

  validates :nombre, :assignature_id, :evaluation_type_id, :min, :max, :level_id, :color, presence: true

  def self.assignature_level_based_evaluation assignature, grade, evaluation_type
    if grade.present?
      where(evaluation_type_id: evaluation_type.id, assignature_id: assignature.id, level_id: grade.level_id)
    else
      puts "NO HAY GRADE"
    end
  end

  def self.compare_colors assignature, level, evaluation_type
    if level.present?
      where(evaluation_type_id: evaluation_type.id, assignature_id: assignature.id, level_id: level.id)
    else
      puts "NO HAY LEVEL"
    end
  end
end
