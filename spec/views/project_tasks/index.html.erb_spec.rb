require 'spec_helper'

describe "project_tasks/index.html.erb" do
  before(:each) do
    assign(:project_tasks, [
      stub_model(ProjectTask,
        :project_id => 1,
        :task_name => "Task Name"
      ),
      stub_model(ProjectTask,
        :project_id => 1,
        :task_name => "Task Name"
      )
    ])
  end

  it "renders a list of project_tasks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Task Name".to_s, :count => 2
  end
end
