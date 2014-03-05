class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :id
      t.integer :journal_id
      t.string :email_list
    end
  end
end
