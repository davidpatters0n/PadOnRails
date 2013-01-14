require 'spec_helper'

describe ProjectTask do
  
  it "should belong efforts " do
    ProjectTask.reflect_on_all_associations(:effort).should be_true
  end 
  
   it "should belong efforts " do
  end 
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

