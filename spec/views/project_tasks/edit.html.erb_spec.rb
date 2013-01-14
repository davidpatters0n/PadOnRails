require 'spec_helper'

describe "project_tasks/edit.html.erb" do
  before(:each) do
    @project_task = assign(:project_task, stub_model(ProjectTask,
      :project_id => 1,
      :task_name => "MyString"
    ))
  end

  it "renders the edit project_task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => project_tasks_path(@project_task), :method => "post" do
      assert_select "input#project_task_project_id", :name => "project_task[project_id]"
      assert_select "input#project_task_task_name", :name => "project_task[task_name]"
    end
  end
end
