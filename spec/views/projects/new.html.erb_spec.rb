require 'spec_helper'

describe "projects/new.html.erb" do
  before(:each) do
    assign(:project, stub_model(Project,
      :project_number => "MyString",
      :project_name => "MyString",
      :manager_user_id => 1
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path, :method => "post" do
      assert_select "input#project_project_number", :name => "project[project_number]"
      assert_select "input#project_project_name", :name => "project[project_name]"
      assert_select "input#project_manager_user_id", :name => "project[manager_user_id]"
    end
  end
end
