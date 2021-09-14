class AddComentarioToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :comentario, :string
  end
end
