class CreatePasswordHistories < ActiveRecord::Migration
  def self.up
    create_table :password_histories do |t|
      
      t.integer :user_id
      t.string  :encrypted_password
      t.timestamps
    end
  end

  def self.down
    drop_table :password_histories
  end
end
