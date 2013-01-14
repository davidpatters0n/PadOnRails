require 'spec_helper'

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CompaniesController do

  def valid_attributes
    {:name => "Example",
     :address => "Example",
     :telephone => "02089528522",
     :email => "ahmet@dai.co.uk"}
  end
  
  include Devise::TestHelpers
  render_views 
  
  before(:each) do
    @user = Factory(:user)
    sign_in @user
  end
    
  describe "GET index" do
    
    it "should be successful if Admin" do
      @user.has_role!(:Admin)
       get 'index'
      response.should be_success
    end
    
    it "should be successful if Project Manager" do
      @user.has_role!(:ProjectManager)
      get 'index'
      response.should be_success
    end
    
    it "should be unsuccessful if Developer" do
        @user.has_role!(:Developer)
        get 'index'
        response.should_not be_success
    end
    
    it "should be unsuccessful if Corporate" do
        @user.has_role!(:Corporate)
        get 'index'
        response.should_not be_success
    end
    
    it "should be unsuccessful if Team Leader" do
        @user.has_role!(:TeamLeader)
        get 'index'
        response.should_not be_success
    end
    
    it "should be unsuccessful if Engineer" do
        @user.has_role!(:Engineer)
        get 'index'
        response.should_not be_success
    end
    
    it "should be unsuccessful if NO ROLE" do
      get 'index'
      response.should_not be_success
    end

    it "should have the right title" do
      @user.has_role!(:Admin)
      get 'index'
      response.should have_selector("title", :content => "Customer Relation Management")
    end
    
    it "assigns all companies as @companies" do
      @user.has_role!(:Admin)
      company = Company.create! valid_attributes
      get :index
      assigns(:companies).should eq([company])
    end
  end

  describe "GET show" do
    it "assigns the requested company as @company" do
      @user.has_role!(:Admin)
      company = Company.create! valid_attributes
      get :show, :id => company.id.to_s
      assigns(:company).should eq(company)
    end
  end

  describe "GET new" do
    it "assigns a new company as @company" do
      @user.has_role!(:Admin)
      get :new
      assigns(:company).should be_a_new(Company)
    end
  end

  describe "GET edit" do
    it "assigns the requested company as @company" do
      @user.has_role!(:Admin)
      company = Company.create! valid_attributes
      get :edit, :id => company.id.to_s
      assigns(:company).should eq(company)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Company" do
        @user.has_role!(:Admin)
        expect {
          post :create, :company => valid_attributes
        }.to change(Company, :count).by(1)
      end

      it "assigns a newly created company as @company" do
        @user.has_role!(:Admin)
        post :create, :company => valid_attributes
        assigns(:company).should be_a(Company)
        assigns(:company).should be_persisted
      end

      it "redirects to the created company" do
        @user.has_role!(:Admin)
        post :create, :company => valid_attributes
        response.should redirect_to(crm_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved company as @company" do
        @user.has_role!(:Admin)
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stub(:save).and_return(false)
        post :create, :company => {}
        assigns(:company).should be_a_new(Company)
      end

      it "re-renders the 'new' template" do
        @user.has_role!(:Admin)
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stub(:save).and_return(false)
        post :create, :company => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested company" do
        @user.has_role!(:Admin)
        company = Company.create! valid_attributes
        # Assuming there are no other companies in the database, this
        # specifies that the Company created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Company.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => company.id, :company => {'these' => 'params'}
      end

      it "assigns the requested company as @company" do
        @user.has_role!(:Admin)
        company = Company.create! valid_attributes
        put :update, :id => company.id, :company => valid_attributes
        assigns(:company).should eq(company)
      end

      it "redirects to the company" do
        @user.has_role!(:Admin)
        company = Company.create! valid_attributes
        put :update, :id => company.id, :company => valid_attributes
        response.should redirect_to(crm_path)
      end
    end

    describe "with invalid params" do
      it "assigns the company as @company" do
        @user.has_role!(:Admin)
        company = Company.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stub(:save).and_return(false)
        put :update, :id => company.id.to_s, :company => {}
        assigns(:company).should eq(company)
      end

      it "re-renders the 'edit' template" do
        @user.has_role!(:Admin)
        company = Company.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stub(:save).and_return(false)
        put :update, :id => company.id.to_s, :company => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested company" do
      @user.has_role!(:Admin)
      company = Company.create! valid_attributes
      expect {
        delete :destroy, :id => company.id.to_s
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the companies list" do
      @user.has_role!(:Admin)
      company = Company.create! valid_attributes
      delete :destroy, :id => company.id.to_s
      response.should redirect_to(crm_path)
    end
  end

end
