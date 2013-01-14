class RemoveNotes < ActiveRecord::Migration
  def self.up
    drop_table :companies
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :telephone
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
