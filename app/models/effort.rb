class Effort < ActiveRecord::Base
  belongs_to :project_task
  belongs_to :project
  belongs_to :user
end


# == Schema Information
#
# Table name: efforts
#
#  id              :integer(4)      not null, primary key
#  project_task_id :integer(4)
#  user_id         :integer(4)
#  week_commencing :date
#  hours           :float
#  created_at      :datetime
#  updated_at      :datetime
#

