class AddInstrumentDocumentFileToInstruments < ActiveRecord::Migration
  def up
    add_attachment :instruments, :instrument_document
  end

  def down
    remove_attachment :instruments, :instrument_document
  end
end
