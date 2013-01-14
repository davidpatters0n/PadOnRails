require 'spec_helper'

describe DashboardController do
  include Devise::TestHelpers
  render_views
  
      before(:each) do
      @user = Factory(:user)
      sign_in @user
  end
  describe "GET 'index'" do
    
    it "should be unsuccessful for NOROLE" do
      get 'index'
      response.should_not be_success
    end
    
    it "should be successful for Admin" do
      @user.has_role!(:Admin)
      get 'index'
      response.should be_success
    end
    
    it "should be successful for Project Manager" do
      @user.has_role!(:ProjectManager)
      get 'index'
      response.should be_success
    end
    
    it "should be unsuccessful for Developer" do
      @user.has_role!(:Developer)
      get 'index'
      response.should_not be_success
    end
    
    it "should be unsuccessful for Corporate" do
      @user.has_role!(:Corporate)
      get 'index'
      response.should_not be_success
    end
    
    it "should be unsuccessful for TeamLeader" do
      @user.has_role!(:TeamLeader)
      get 'index'
      response.should_not be_success
    end

    it "should be unsuccessful for Engineer" do
      @user.has_role!(:Engineer)
      get 'index'
      response.should_not be_success
    end
    
    it "should have the right title for Admin" do
      @user.has_role!(:Admin)
      get 'index'
      response.should have_selector("title", :content => "Dashboard")
    end
    
    it "should have the right title for Project Manager" do
      @user.has_role!(:ProjectManager)
      get 'index'
      response.should have_selector("title", :content => "Dashboard")
    end
  end
end