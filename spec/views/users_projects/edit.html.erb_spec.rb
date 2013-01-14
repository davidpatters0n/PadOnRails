require 'spec_helper'

describe "users_projects/edit.html.erb" do
  before(:each) do
    @users_project = assign(:users_project, stub_model(UsersProject,
      :user_id => 1,
      :project_id => 1
    ))
  end

  it "renders the edit users_project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_projects_path(@users_project), :method => "post" do
      assert_select "input#users_project_user_id", :name => "users_project[user_id]"
      assert_select "input#users_project_project_id", :name => "users_project[project_id]"
    end
  end
end
