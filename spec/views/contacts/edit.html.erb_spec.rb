require 'spec_helper'

describe "contacts/edit.html.erb" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :name => "MyString",
      :position => "MyString",
      :email => "MyString",
      :telephone => "MyString",
      :source => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contacts_path(@contact), :method => "post" do
      assert_select "input#contact_name", :name => "contact[name]"
      assert_select "input#contact_position", :name => "contact[position]"
      assert_select "input#contact_email", :name => "contact[email]"
      assert_select "input#contact_telephone", :name => "contact[telephone]"
      assert_select "input#contact_source", :name => "contact[source]"
    end
  end
end
