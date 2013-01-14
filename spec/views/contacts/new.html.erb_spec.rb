require 'spec_helper'

describe "contacts/new.html.erb" do
  before(:each) do
    assign(:contact, stub_model(Contact,
      :name => "MyString",
      :position => "Position",
      :email => "MyString",
      :telephone => "MyString",
      :source => "MyString"
    ).as_new_record)
  end

  it "renders new contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contacts_path, :method => "post" do
      assert_select "input#contact_name", :name => "contact[name]"
      assert_select "input#contact_position", :name => "contact[position]"
      assert_select "input#contact_email", :name => "contact[email]"
      assert_select "input#contact_telephone", :name => "contact[telephone]"
      assert_select "input#contact_source", :name => "contact[source]"
    end
  end
end
