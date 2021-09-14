class AddHtmlToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :html, :text
  end
end
