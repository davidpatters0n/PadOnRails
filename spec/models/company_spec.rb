require 'spec_helper'



describe Company do
  before(:each) do
    @company = Factory(:company)
    @attr = {
      :name => "Example",
      :address => "123 Shark Road London England SW1 9EP",
      :telephone => "02082860642",
      :email => "example@dai.co.uk",

    }
  end
  it "should create a new instance given valid attributes" do
    Company.create!(@attr)

  end

  it "should have name attached to comment" do
    no_name_comment = Company.new(@attr.merge(:name => ""))
    no_name_comment.should_not be_valid
  end

  it "should have address attached to comment" do
    no_address_comment = Company.new(@attr.merge(:address => ""))
    no_address_comment.should_not be_valid
  end

  it "should have email attached to comment" do
    no_email_comment = Company.new(@attr.merge(:email => ""))
    no_email_comment.should_not be_valid
  end

  it "should NOT be valid with wrong formatted email" do
    wrong_format_email = Company.new(@attr.merge(:email => 'b@infor'))
    wrong_format_email.should_not be_valid #wrong

  end

  it "should accept valid email addresses" do
    valid_address = %W[user@example.com THE_USER@example.bar.org first.last@foo.jp]
    valid_address.each do |address|
      valid_email_user = Company.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should have many contacts" do
    Company.reflect_on_association(:contacts).should be_true
  end

  it "should have many comments" do
    Company.reflect_on_association(:comments).should be_true
  end
end


# == Schema Information
#
# Table name: companies
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  address    :string(255)
#  telephone  :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

