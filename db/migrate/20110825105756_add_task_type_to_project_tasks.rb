class AddTaskTypeToProjectTasks < ActiveRecord::Migration
  def self.up
    add_column :project_tasks, :taskType, :string
  end

  def self.down
    remove_column :project_tasks, :taskType
  end
end
