class Question < ActiveRecord::Base
  resourcify
  belongs_to :advice
  belongs_to :assignature
  belongs_to :level
  belongs_to :content
  belongs_to :bloom_ability
  belongs_to :axis
  belongs_to :pme_ability
  #has_and_belongs_to_many :learning_goals
  has_many :learning_questions
  has_many :learning_goals, :through => :learning_questions
  belongs_to :difficulty_level
  has_and_belongs_to_many :units
  belongs_to :axis_program
  belongs_to :assignature_ability
  has_many :alternatives, :dependent => :destroy
  accepts_nested_attributes_for :alternatives, :reject_if => :all_blank, :allow_destroy => true
  has_many :instrument_questions_positions, :dependent => :delete_all
  has_many :instrument_alternatives_positions, :dependent => :delete_all
  has_and_belongs_to_many :evaluations
  belongs_to :group_question, inverse_of: :questions
  has_many :guides, :dependent => :delete_all
  validates :assignature_id, :level_id, presence: true

  def alternative_index
     instrument = self.evaluations.last.instruments.last
     instrument.guides.where(:question_id => self.id).first.alternative_index rescue nil
  end
end
