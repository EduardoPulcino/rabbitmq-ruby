class CreateEmails < ActiveRecord::Migration[8.1]
  def change
    create_table :emails do |t|
      t.string :email
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
