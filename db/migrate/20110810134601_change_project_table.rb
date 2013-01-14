class ChangeProjectTable < ActiveRecord::Migration
  def self.up
    drop_table :projects
    create_table :projects do |t|
      t.string :project_number
      t.string :project_name
      t.string :manager_user_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :projects
  end
end