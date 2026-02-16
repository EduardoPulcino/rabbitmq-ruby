class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.string :email
      t.string :subject
      t.string :content

      t.timestamps
    end
  end
end
