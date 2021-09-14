class RemoveFileColumnsFromInstrument < ActiveRecord::Migration
  def change
    remove_column :instruments, :html, :text
    remove_column :instruments, :instrument_document_updated_at, :datetime
    remove_column :instruments, :instrument_document_file_size, :integer
    remove_column :instruments, :instrument_document_content_type, :string
    remove_column :instruments, :instrument_document_file_name, :string
  end
end
