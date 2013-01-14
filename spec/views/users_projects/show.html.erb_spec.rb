require 'spec_helper'

describe "users_projects/show.html.erb" do
  before(:each) do
    @users_project = assign(:users_project, stub_model(UsersProject,
      :user_id => 1,
      :project_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
