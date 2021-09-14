class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.bigint :contact
      t.string :email
      t.string :subject
      t.text :message
      t.integer :school_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
