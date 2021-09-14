class Evaluation < ActiveRecord::Base
  resourcify
  belongs_to :evaluation_type
  belongs_to :assignature
  belongs_to :level
  has_and_belongs_to_many :questions
  has_many :instruments, :dependent => :destroy
  after_create :instrumentalize
  after_update :sync_instrument

  validates :nombre, :year, :evaluation_type_id, :assignature_id,
  :level_id, presence: true

  has_attached_file :pdfguide, styles: {thumbnail: "60x60#"}
  validates_attachment :pdfguide, content_type: { content_type: "application/pdf" }

  def to_label
    "#{nombre}"
  end

  def instrumentalize
    #crea un instrumento default igual a la evaluacion
    letters_array = ("A".."Z").to_a
    instrument = Instrument.create(:nombre => self.nombre, :evaluation_id => self.id)
    create_index(instrument, letters_array)
  end

  def sync_instrument
    if self.instruments.present?
      instrument = Instrument.find_by(evaluation_id: self.id)
      instrument.instrument_questions_positions.destroy_all
      instrument.guides.destroy_all
      create_index(instrument, ("A".."Z").to_a)
      instrument.nombre = self.nombre
      instrument.save
    end
  end

  def create_index(instrument, alpha)
    instrument.evaluation.questions.each_with_index { |question, index|
      question_position = InstrumentQuestionsPosition.create(
        instrument_id: instrument.id, question_id: question.id, position: (index + 1))
      question.alternatives.order('id asc').each_with_index { |a, i|
        InstrumentAlternativesPosition.create(
          instrument_id: instrument.id, question_id: question.id, alternative_id: a.id,
          instrument_questions_position_id: question_position.id, position: alpha[i]
        )

        if a.correcta?
          Guide.create(instrument_id: instrument.id, question_id: question.id, alternative_id: a.id, alternative_index: alpha[i], question_index: index+1)
        end
      }
    }
  end
end
