class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :position
      t.string :email
      t.string :telephone
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
