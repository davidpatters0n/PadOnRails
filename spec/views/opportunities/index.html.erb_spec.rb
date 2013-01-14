require 'spec_helper'


describe "opportunities/index.html.erb" do
  before(:each) do
    assign(:opportunities, [

      stub_model(Opportunity,

        :name => "Name",

        :status => "Status",

        :sbustream => "Sbustream",

        :value => "Value",

        :daiowner => "Daiowner",

        :companyname => "Companyname",

        :contacts => "Contacts"


      ),


      stub_model(Opportunity,

        :name => "Name",

        :status => "Status",

        :sbustream => "Sbustream",

        :value => "Value",

        :daiowner => "Daiowner",

        :companyname => "Companyname",

        :contacts => "Contacts"


      )


    ])
  end

  it "renders a list of opportunities" do
    render


    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Sbustream".to_s, :count => 2



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Daiowner".to_s, :count => 2



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Companyname".to_s, :count => 2



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Contacts".to_s, :count => 2


  end
end
