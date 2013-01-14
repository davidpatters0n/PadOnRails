require 'spec_helper'



describe Contact do
  before(:each) do
    @contact = Factory(:contact)
    @attr = {
      :name => "Example",
      :position => "Position",
      :telephone => "02082860634",
      :email => "example@dai.co.uk",
      :source => "www.dai.co.uk",
      :company_id => "dai",
    }
  end

  it "should create a new instance give valid attributes" do
    Contact.create!(@attr)
  end

  it "should require contact name" do
    no_name_contact = Contact.new(@attr.merge(:name => ""))
    no_name_contact.should_not be_valid
  end

  it "should require a position" do
    no_position_contact = Contact.new(@attr.merge(:position => ""))
    no_position_contact.should_not be_valid
  end

  it "should require a telephone" do
    no_telephone_contact = Contact.new(@attr.merge(:telephone => ""))
    no_telephone_contact.should_not be_valid
  end

  it "should require email" do
    no_email_contact = Contact.new(@attr.merge(:email => ""))
    no_email_contact.should_not be_valid
  end

  it "should require a source" do
    no_source_contact = Contact.new(@attr.merge(:source => ""))
    no_source_contact.should_not be_valid
  end

  it "should require a company id" do
    no_companyId_contact = Contact.new(@attr.merge(:company_id => ""))
    no_companyId_contact.should_not be_valid
  end

  it "should accept valid email addresses" do
    valid_address = %W[user@example.com THE_USER@example.bar.org first.last@foo.jp]
    valid_address.each do |address|
      valid_email_user = Contact.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

    it "should reject invalid email addresses" do
    invalid_address = %w[user@example,com TEST_USER_at_org_com example.user@foo.]
    invalid_address.each do |address|
      invalid_email_user = Contact.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

 it "should accept valid telephone number" do 
   valid_telephone = %W[07908224027 02082860642 07956226217]
   valid_telephone.each do |telephone|
     valid_telephone_user = Contact.new(@attr.merge(:telephone => telephone))
     valid_telephone_user.should be_valid
   end
 end
 
 
 it "shouldn't telephone number" do 
   invalid_telephone = %w[+4479082.24027 +123-2345-3f45 555-4s22-1234]
   invalid_telephone.each do |telephone|
     invalid_telephone_user = Contact.new(@attr.merge(:telephone => telephone))
     invalid_telephone_user.should_not be_valid
   end
 end
 
  it "should reject http url source that are too short" do

    short_url = "a" * 3
    short_url_source = @attr.merge(:source => short_url_source)
    Contact.new(short_url_source).should_not be_valid 
  end
 
  it "should relate to comapny" do
    Contact.reflect_on_association(:company).should_not be_nil
  end
  
  it "should have many comments" do 
    Contact.reflect_on_association(:comments).should be_nil
  end
end


# == Schema Information
#
# Table name: contacts
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  position   :string(255)
#  email      :string(255)
#  telephone  :string(255)
#  source     :string(255)
#  company_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

