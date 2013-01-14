class ChangeUploader < ActiveRecord::Migration
  def self.up
    remove_column :comments, :commentfile, :string
    add_column :comments, :file, :string
  end

  def self.down
    remove_column :comments, :file, :string
  end
end
