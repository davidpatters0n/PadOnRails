require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe ContactsController do

  # This should return the minimal set of attributes required to create a valid
  # Contact. As you add validations to Contact, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => "Example",
     :position => "Position",
     :email => "example@dai.co.uk",
     :telephone => "02089429252",
     :source => "http://www.google.com",
     :company_id => 1}
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
    
    it "assigns all contacts as @contacts" do
      @user.has_role!(:Admin)
      contact = Contact.create! valid_attributes 
      get :index
      assigns(:contacts).should eq([contact])
    end
  end

  #describe "GET show" do
    #it "assigns the requested contact as @contact" do
     # @user.has_role!(:Admin)
      #contact = Contact.create! valid_attributes
      #get :show, :id => contact.id.to_s
      #assigns(:contact).should eq(contact)
    #end
  #end

  describe "GET new" do
    it "assigns a new contact as @contact" do
      @user.has_role!(:Admin)
      get :new
      assigns(:contact).should be_a_new(Contact)
    end
  end

  describe "GET edit" do
    it "assigns the requested contact as @contact" do
      @user.has_role!(:Admin)
      contact = Contact.create! valid_attributes
      get :edit, :id => contact.id.to_s
      assigns(:contact).should eq(contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Contact" do
        @user.has_role!(:Admin)
        expect {
          post :create, :contact => valid_attributes
        }.to change(Contact, :count).by(1)
      end

      it "assigns a newly created contact as @contact" do
        @user.has_role!(:Admin)
        post :create, :contact => valid_attributes
        assigns(:contact).should be_a(Contact)
        assigns(:contact).should be_persisted
      end

      it "redirects to the created contact" do
        @user.has_role!(:Admin)
        post :create, :contact => valid_attributes
        response.should redirect_to(crm_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved contact as @contact" do
        @user.has_role!(:Admin)
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        post :create, :contact => {}
        assigns(:contact).should be_a_new(Contact)
      end

      it "re-renders the 'new' template" do
        @user.has_role!(:Admin)
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        post :create, :contact => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested contact" do
        @user.has_role!(:Admin)
        contact = Contact.create! valid_attributes
        # Assuming there are no other contacts in the database, this
        # specifies that the Contact created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Contact.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => contact.id, :contact => {'these' => 'params'}
      end

      it "assigns the requested contact as @contact" do
        @user.has_role!(:Admin)
        contact = Contact.create! valid_attributes
        put :update, :id => contact.id, :contact => valid_attributes
        assigns(:contact).should eq(contact)
      end

      it "redirects to the contact" do
        @user.has_role!(:Admin)
        contact = Contact.create! valid_attributes
        put :update, :id => contact.id, :contact => valid_attributes
        response.should redirect_to(crm_path)
      end
    end

    describe "with invalid params" do
      it "assigns the contact as @contact" do
        @user.has_role!(:Admin)
        contact = Contact.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        put :update, :id => contact.id.to_s, :contact => {}
        assigns(:contact).should eq(contact)
      end

      it "re-renders the 'edit' template" do
        @user.has_role!(:Admin)
        contact = Contact.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        put :update, :id => contact.id.to_s, :contact => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested contact" do
      @user.has_role!(:Admin)
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, :id => contact.id.to_s
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
      @user.has_role!(:Admin)
      contact = Contact.create! valid_attributes
      delete :destroy, :id => contact.id.to_s
      response.should redirect_to(crm_path)
    end
  end

end
