require 'spec_helper'



describe Effort do

  it "should belong project task " do
    Effort.reflect_on_all_associations(:project_task).should be_true

  end

  it "should belong to project" do
    Effort.reflect_on_association(:project).should be_true
  end

  it "should belong to user" do
    Effort.reflect_on_association(:user).should be_true
  end
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

