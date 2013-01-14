class ProjectTask < ActiveRecord::Base
  belongs_to :project
  has_many :efforts
end


# == Schema Information
#
# Table name: project_tasks
#
#  id         :integer(4)      not null, primary key
#  project_id :integer(4)
#  task_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  taskType   :string(255)
#

