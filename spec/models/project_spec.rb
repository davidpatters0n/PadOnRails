require 'spec_helper'



describe Project do

  before(:each) do
    @attr = {
      :project_number => "12EX",
      :project_name => "ExampleName",
      :manager_user_id => "ExampleDude",
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@attr)
  end

  it "should have a project number" do
    no_project_number = Project.new(@attr.merge(:project_number => ""))
    no_project_number.should_not be_valid
  end

  it "should have a project name" do
    no_project_name = Project.new(@attr.merge(:project_name => ""))
    no_project_name.should_not be_valid
  end
  it "should have a manager id name" do
    no_project_manager_id = Project.new(@attr.merge(:manager_user_id => ""))
    no_project_manager_id.should_not be_valid
  end

  it "should accept valid project number" do
    valid_project = %W[5000R DM0400 S005D]
    valid_project.each do |project_number|
      valid_project_number = Project.new(@attr.merge(:project_number => project_number))
      valid_project_number.should be_valid
    end
  end

  it "should reject a project number less than 4 characters" do
    short_project_number = "a" * 3
    project_number = @attr.merge(:project_number => short_project_number )
    Project.new(project_number).should_not be_valid
  end
end



# == Schema Information
#
# Table name: projects
#
#  id              :integer(4)      not null, primary key
#  project_number  :string(255)
#  project_name    :string(255)
#  manager_user_id :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  account_manager :string(255)
#

