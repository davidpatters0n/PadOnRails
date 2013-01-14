require 'spec_helper'



describe User do
  before(:each) do
    @user = Factory(:user_normal)
    @attr = {
      :username => "Example",
      :full_name => "Example User",
      :email => "example@dai.co.uk",
      :password => "example222",
      :password_confirmation => "example222"

    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require username" do
    no_username_user = User.new(@attr.merge(:username => ""))
    no_username_user.should_not be_valid
  end

  it "should require a full name" do
    no_name_user = User.new(@attr.merge(:full_name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should require a password" do
    no_password_user = User.new(@attr.merge(:password => ""))
    no_password_user.should_not be_valid
  end

  it "should require password confirmation" do
    no_password_confirmation_user = User.new(@attr.merge(:password_confirmation => ""))
    no_password_confirmation_user.should_not be_valid
  end

  it "should reject short passwords" do
    short = "a" * 4
    hash = @attr.merge(:password => short, :password_confirmation => short)
    User.new(hash).should_not be_valid
  end

  it "should NOT be valid with wrong formatted email" do
    wrong_format_email = User.new(@attr.merge(:email => 'b@infor'))
    wrong_format_email.should_not be_valid #wrong

  end

  it "should not be valid without password confirmation" do
    password = User.new(@attr.merge(:password => 'password'))
    wrong_confirmation = User.new(@attr.merge(:password_confirmation => 'nil'))
    wrong_confirmation.should_not be_valid
  end

  it "should not be valid with confirmation not matching password" do
    password = User.new(@attr.merge(:password => 'password'))
    password_match_wrong = User.new(@attr.merge(:password_confirmation => 'not confirmed'))
    password_match_wrong.should_not be_valid

  end

  it "should not be valid with duplicate user email" do

    user = User.new(@user)
    duplicate_user = User.new(@attr.merge( :username => 'Example1',
    :email => 'example1@dai.co.uk'))
    duplicate_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    valid_address = %W[user@example.com THE_USER@example.bar.org first.last@foo.jp]
    valid_address.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    invalid_address = %w[user@example,com TEST_USER_at_org_com example.user@foo.]
    invalid_address.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should have many role users" do
    User.reflect_on_all_associations(:roles_user).should be_true
  end

  it "should have many roles" do
    User.reflect_on_association(:roles).should be_true
  end

  it "should have many projects" do
    User.reflect_on_association(:projects).should be_true
  end

  it "should have many efforts" do
    User.reflect_on_association(:efforts).should be_true
  end

  it "should have many user projects" do
    User.reflect_on_all_associations(:user_projects).should be_true
  end
end


# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  password_salt          :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  failed_attempts        :integer(4)      default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  full_name              :string(255)
#

