require 'spec_helper'

describe "efforts/show.html.erb" do
  before(:each) do
    @effort = assign(:effort, stub_model(Effort,
      :project_task_id => 1,
      :user_id => 1,
      :hours => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
