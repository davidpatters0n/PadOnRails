class CreateUsersProjects < ActiveRecord::Migration
  def self.up
    create_table :users_projects do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users_projects
  end
end
