require 'spec_helper'

describe "efforts/index.html.erb" do
  before(:each) do
    assign(:efforts, [
      stub_model(Effort,
        :project_task_id => 1,
        :user_id => 1,
        :hours => ""
      ),
      stub_model(Effort,
        :project_task_id => 1,
        :user_id => 1,
        :hours => ""
      )
    ])
  end

  it "renders a list of efforts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
