class AddAccountManagerToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :account_manager, :string
  end

  def self.down
    remove_column :projects, :account_manager
  end
end
