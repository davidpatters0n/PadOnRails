require 'spec_helper'

describe "efforts/edit.html.erb" do
  before(:each) do
    @effort = assign(:effort, stub_model(Effort,
      :project_task_id => 1,
      :user_id => 1,
      :hours => ""
    ))
  end

  it "renders the edit effort form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => efforts_path(@effort), :method => "post" do
      assert_select "input#effort_project_task_id", :name => "effort[project_task_id]"
      assert_select "input#effort_user_id", :name => "effort[user_id]"
      assert_select "input#effort_hours", :name => "effort[hours]"
    end
  end
end
