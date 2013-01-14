require 'spec_helper'

describe "project_tasks/show.html.erb" do
  before(:each) do
    @project_task = assign(:project_task, stub_model(ProjectTask,
      :project_id => 1,
      :task_name => "Task Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Task Name/)
  end
end
