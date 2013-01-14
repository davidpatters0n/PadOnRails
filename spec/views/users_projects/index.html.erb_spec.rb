require 'spec_helper'

describe "users_projects/index.html.erb" do
  before(:each) do
    assign(:users_projects, [
      stub_model(UsersProject,
        :user_id => 6,
        :project_id => 2
      ),
      stub_model(UsersProject,
        :user_id => 6,
        :project_id => 2
      )
    ])
  end

  it "renders a list of users_projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 6.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
