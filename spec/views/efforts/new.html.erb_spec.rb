require 'spec_helper'

describe "efforts/new.html.erb" do
  before(:each) do
    assign(:effort, stub_model(Effort,
      :project_task_id => 1,
      :user_id => 1,
      :hours => ""
    ).as_new_record)
  end

  it "renders new effort form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => efforts_path, :method => "post" do
      assert_select "input#effort_project_task_id", :name => "effort[project_task_id]"
      assert_select "input#effort_user_id", :name => "effort[user_id]"
      assert_select "input#effort_hours", :name => "effort[hours]"
    end
  end
end
