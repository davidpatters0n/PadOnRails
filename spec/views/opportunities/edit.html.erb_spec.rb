require 'spec_helper'


describe "opportunities/edit.html.erb" do
  before(:each) do
    @opportunity = assign(:opportunity, stub_model(Opportunity,

      :name => "MyString",

      :status => "MyString",

      :sbustream => "MyString",

      :value => "MyString",

      :daiowner => "MyString",

      :companyname => "MyString",

      :contacts => "MyString"

    ))

  end

  it "renders the edit opportunity form" do
    render


    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => opportunities_path(@opportunity), :method => "post" do

      assert_select "input#opportunity_name", :name => "opportunity[name]"

      assert_select "input#opportunity_status", :name => "opportunity[status]"

      assert_select "input#opportunity_sbustream", :name => "opportunity[sbustream]"

      assert_select "input#opportunity_value", :name => "opportunity[value]"

      assert_select "input#opportunity_daiowner", :name => "opportunity[daiowner]"

      assert_select "input#opportunity_companyname", :name => "opportunity[companyname]"

      assert_select "input#opportunity_contacts", :name => "opportunity[contacts]"

    end

  end
end
