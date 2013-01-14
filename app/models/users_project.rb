class UsersProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
end

# == Schema Information
#
# Table name: users_projects
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  project_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

