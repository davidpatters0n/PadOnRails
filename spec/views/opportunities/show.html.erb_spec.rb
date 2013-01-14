require 'spec_helper'


describe "opportunities/show.html.erb" do
  before(:each) do
    @opportunity = assign(:opportunity, stub_model(Opportunity,

      :name => "Name",

      :status => "Status",

      :sbustream => "Sbustream",

      :value => "Value",

      :daiowner => "Daiowner",

      :companyname => "Companyname",

      :contacts => "Contacts"


    ))

  end

  it "renders attributes in <p>" do
    render


    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Sbustream/)



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Daiowner/)



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Companyname/)



    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Contacts/)


  end
end
