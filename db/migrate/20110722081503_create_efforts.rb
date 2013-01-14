class CreateEfforts < ActiveRecord::Migration
  def self.up
    create_table :efforts do |t|
      t.integer :project_task_id
      t.integer :user_id
      t.date :week_commencing
      t.float :hours

      t.timestamps
    end
  end

  def self.down
    drop_table :efforts
  end
end
