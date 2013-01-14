require 'spec_helper'

describe "companies/new.html.erb" do
  before(:each) do
    assign(:company, stub_model(Company,
      :name => "MyString",
      :address => "MyString",
      :telephone => "MyString",
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new company form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => companies_path, :method => "post" do
      assert_select "input#company_name", :name => "company[name]"
      assert_select "input#company_address", :name => "company[address]"
      assert_select "input#company_telephone", :name => "company[telephone]"
      assert_select "input#company_email", :name => "company[email]"
    end
  end
end
