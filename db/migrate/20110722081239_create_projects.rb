class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :project_number
      t.string :project_name
      t.integer :manager_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end