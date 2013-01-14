class ChangeContacts < ActiveRecord::Migration
  def self.up
    drop_table :contacts
    create_table :contacts do |t|
      t.string :name
      t.string :position
      t.string :email
      t.string :telephone
      t.string :source
      t.references :company
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
