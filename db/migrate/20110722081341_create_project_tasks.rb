class CreateProjectTasks < ActiveRecord::Migration
  def self.up
    create_table :project_tasks do |t|
      t.integer :project_id
      t.string :task_name

      t.timestamps
    end
  end

  def self.down
    drop_table :project_tasks
  end
end
