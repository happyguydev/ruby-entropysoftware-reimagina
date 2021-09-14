class AddAttachmentPdfguideToEvaluations < ActiveRecord::Migration
  def self.up
    change_table :evaluations do |t|
      t.attachment :pdfguide
    end
  end

  def self.down
    remove_attachment :evaluations, :pdfguide
  end
end
