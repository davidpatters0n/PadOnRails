require 'spec_helper'

describe UsermanagementController do
  include Devise::TestHelpers
  render_views
  
  describe "GET 'index'" do   
          before(:each) do
          @user = Factory(:user)
          sign_in @user
        end
    it "as an admin; should be successful" do
      @user.has_role!(:Admin)
      get 'index'
      response.should be_success
    end
    
    it "as an developer; should be unsuccessful" do
      @user.has_role!(:Developer)
      get 'index'
      response.should_not be_success
    end
    
    it "as an corporate; should be unsuccessful" do
      @user.has_role!(:Corporate)
      get 'index'
      response.should_not be_success
    end
    
    it "as an project manager; should be unsuccessful" do
      @user.has_role!(:ProjectManager)
      get 'index'
      response.should_not be_success
    end
    
    it "as an team leader; should be unsuccessful" do
      @user.has_role!(:TeamLeader)
      get 'index'
      response.should_not be_success
    end
    
    it "as an engineer; should be unsuccessful" do
      @user.has_role!(:Engineer)
      get 'index'
      response.should_not be_success
    end
    
    it "as an admin; should have the right title" do
      @user.has_role!(:Admin)
      get 'index'
      response.should have_selector("title", :content => "User Management")
    end
    
    it "as a regular user; should be unsuccesful" do
      get 'index'
      response.should_not be_success
      response.should redirect_to(timesheet_path)
    end
end
end
