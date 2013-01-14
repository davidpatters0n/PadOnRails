class CreateUploader < ActiveRecord::Migration
  def self.up
    add_column :comments, :commentfile, :string
  end

  def self.down
    remove_column :comments, :commentfile, :string
  end
end
