require 'spec_helper'

describe "users_projects/new.html.erb" do
  before(:each) do
    assign(:users_project, stub_model(UsersProject,
      :user_id => 1,
      :project_id => 1
    ).as_new_record)
  end

  it "renders new users_project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_projects_path, :method => "post" do
      assert_select "input#users_project_user_id", :name => "users_project[user_id]"
      assert_select "input#users_project_project_id", :name => "users_project[project_id]"
    end
  end
end
