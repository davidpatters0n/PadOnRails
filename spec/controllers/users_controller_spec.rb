require 'spec_helper'

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  
  include Devise::TestHelpers
  render_views 
  
   describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)    
      @attr = Factory(:user_normal)
      sign_in @user
    end
    
    it "should be successful when showing your own details" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do 
      get :show, :id => @user
      assigns(:user).should == @user
    end
            
    it "should have the right title" do 
      get :show, :id => @user
      response.should have_selector("title", :content => "My Account")
    end
    
    it "as an admin; 'show' regular user" do      
      @user.has_role!(:Admin) 
      get :show, :id => @attr
      assigns(:user).should == @attr 
      response.should be_success
    end 
    
    it "should have the right title when viewing his/her own account as an admin" do
      @user.has_role!(:Admin)
      get :show, :id => @user 
      response.should have_selector("title", :content => "#{@user.full_name}'s Account")     
    end
    
    it "should have the right title when viewing someone else's account as an admin" do
      @user.has_role!(:Admin)
      get :show, :id => @attr 
      response.should have_selector("title", :content => "#{@attr.full_name}'s Account")     
    end
  end # finishing GET show
  
  describe "GET 'new'" do
    
    describe "success" do
 
    before(:each) do
      @user = Factory(:user)
      @normal = Factory(:user_normal)
      sign_in @user
    end
    
        it "should pass if it has the global role" do
      @user.has_role!(:Admin)
      @user.has_role?(:Admin).should be_true
      @user.has_role?(:Example).should be_false
    end
      
    it "should return the right role" do
      @user.has_role!(:Admin)
      @user.has_role?(:Admin).should be_true
    end
    
        it "as an admin; should be successful" do
      @user.has_role!(:Admin)
      get 'new'
      response.should be_success
    end   
    
        it "as an admin; should render new template" do
      @user.has_role!(:Admin)
      get 'new'
      response.should render_template('new')
    end
    
                
    it "as an admin; should have the right title" do
      @user.has_role!(:Admin)
      get 'new'
      response.should have_selector("title", :content => "Create a user")
    end 
  
   end 
   
       
    describe "failure" do

    before(:each) do
      @user = Factory(:user)
      @normal = Factory(:user_normal)
      sign_in @user
    end
    
      it "should be unsuccessful if the user is not an admin" do
      get 'new'
      response.should_not be_success
    end
   end
  end # finishing GET new

 
  
  describe "GET 'edit'" do
    
    before(:each) do
      User.destroy_all 
      @user = Factory(:user)
      @attr = Factory(:user_normal)
      sign_in @user
    end
    it "should be successful when showing the edit page for your own details" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :edit, :id => @user
      assigns(:user).should == @user
    end
            

    
    it "as an admin; 'edit' regular user's details" do
      @user.has_role!(:Admin)
      get :edit, :id => @attr 
      assigns(:user).should == @attr 
 
      response.should be_success
    end
       
  end
  
   describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @user = Factory(:user)
        sign_in @user
        @attr = { :username => "", :full_name => "", :email => "", :password => "",
                  :password_confirmation => "" }        
      end
                           
      it "should not create a user" do
       @user.has_role!(:Admin) 
       lambda do
         post :create, :user => @attr
       end.should_not change(User, :count)
      end
     
      it "should have the right title" do
        @user.has_role!(:Admin)
        post :create, :user => @attr
        response.should have_selector("title", :content => "Create a user")
      end

      it "should render the 'new' page" do
        @user.has_role!(:Admin)
        post :create, :user => @attr
        response.should render_template('new')
      end
      
      it "should be successful" do
        @user.has_role!(:Admin)
        get 'new'
        response.should be_success
      end

      it "should be unsuccessful if the user is not an admin" do
        get 'new'
        response.should_not be_success 
      end
    end
                
    describe "success" do 
      before(:each) do
        @user = Factory(:user)
        @attr = { :username => "UserNew", :full_name => "New User", :email => "newuser@example.com", :password => "newuser",
                  :password_confirmation => "newuser" }
        sign_in @user
      end
                     
      it "should create a user" do
        @user.has_role!(:Admin)
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
 
      it "should redirect to the user management page" do
        @user.has_role!(:Admin)
        post :create, :user => @attr
        response.should redirect_to(usermanagement_path)
      end    
      
      it "should show a notice saying 'Created successfully.'" do
        @user.has_role!(:Admin)
        post :create, :user => @attr
        flash[:success].should =~ /created successfully/i
      end
    end
  end
  
  describe "PUT update" do
       
      describe "success" do
        before(:each) do
              User.destroy_all 
              @user = Factory(:user)
              @anotheruser = Factory(:user_normal)
              sign_in @user
                  @attr = {:full_name => "New User", :email => "newuser@example.com" }
                  
                  
        end
        
        it "should change the user's attributes when the user is updating itself" do
          put :update, :id => @user, :user => @attr
          @user.reload
          @user.full_name.should == @attr[:full_name] 
          @user.email.should == @attr[:email]
        end
        
        it "should change the user's attrbutes when updated by admin" do
          @user.has_role!(:Admin)
          put :update, :id => @anotheruser, :user => @attr
          @anotheruser.reload
          @anotheruser.full_name.should == @attr[:full_name] 
          @anotheruser.email.should == @attr[:email]
          
          
        end
        
        it "should redirect to the user_path when the user is updating itself" do
          put :update, :id => @user, :user => @attr
          response.should redirect_to(user_path(@user))
        end
        
        it "should redirect to the user_path when updated by admin" do
          @user.has_role!(:Admin)
          put :update, :id => @anotheruser, :user => @attr
          response.should redirect_to(user_path(@anotheruser))
        end
         
        it "should redirect to the user_path when admin is updated by admin" do
          @user.has_role!(:Admin)
          put :update, :id => @user, :user => @attr 
          @user.reload
          @user.full_name.should == @attr[:full_name] 
          @user.email.should == @attr[:email]
          
          response.should redirect_to(user_path(@user))
        end #dunno the problem with this test, honestly!!
        
        it "should have a flash message when updating a user as an admin" do
        @user.has_role!(:Admin)
        @user.reload
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /user updated/i  
        end # same problems as the example above
        
        it "should have a flash message when a user is updating itself" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /settings updated/i
        end

      end
      
      describe "failure" do
        before(:each) do
          User.destroy_all 
              @user = Factory(:user)
              @anotheruser = Factory(:user_normal)
              sign_in @user
        @attr = {:full_name => "", :email => "", :password => "",
                  :password_confirmation => "" }
        end
        
      it "should render the 'edit' page for a random user" do
        @user.has_role!(:Admin)
        put :update, :id => @anotheruser, :user => @attr
        response.should render_template('')
      end   
      
      it "should render the 'edit' page for the admin" do
        pending
      end  
      
      end
  end

  describe "POST 'destroy'" do
    describe "success" do
      before(:each) do
        User.destroy_all
        @user = Factory(:user)
        @attr = Factory(:user_normal)
        sign_in @user
      end

      # Should fail until someone stops a user from deleteing itself.
      it "should not delete self user" do
        expect {delete :destroy, :id => @user.id.to_s
          }.to change(User, :count).by(0)
      end
      
      it "should destroy a random user" do
        @user.has_role!(:Admin)
       expect {delete :destroy, :id => @attr.id.to_s
       }.to change(User, :count).by(-1)
      end 
      
      it "should NOT destroy a random user" do
        @user.has_role!(:Developer)
        expect {delete :destroy, :id => @attr.id.to_s
          }.to change(User, :count).by(0) 
      end 
      
      it "should redirect to usermanagement" do
        @user.has_role!(:Admin)
        delete :destroy, :id => @attr.id.to_s
        response.should redirect_to(usermanagement_path)
      end
    end
  end
  
  
  describe "Get 'change password'" do
        
    before(:each) do
      @user = Factory(:user)    
      sign_in @user
    end
    
    it "should be successful" do
      get :change_password, :id => @user
      response.should be_success
    end
 
    it "should find the right user" do 
      get :change_password, :id => @user
      assigns(:user).should == @user
    end
            
    it "should have the right title" do 
      get :change_password, :id => @user  
      response.should have_selector("title", :content => "Change your password")
    end
  end
  
   describe "POST 'update password'" do
      
     describe "success" do
            before(:each) do
            @user = Factory(:user)
            @current_password = "Example"
            sign_in @user
            
            @attr = {:current_password => @current_password, :password => "password", :password_confirmation => "password" }           
            end
      
        it "should check that the current password is correct before updating the password" do
      
          put :update, :id => @user, :user => @attr
          response.should be_success
        end
       
      it "complete failure" do
          put :update, :id => @user, :user => @attr
          @user.reload
          @user.password.should == @attr[:password] 
       #   @user.password_confirmation.should == @attr[:password_confirmation]
        end
      end 
       
    
  end
  describe "acl9 role check" do
    before(:each) do
      @user = Factory(:user)
    end
        
     it "should pass if it has the global role" do
       @user.has_role!(:Admin)
       @user.has_role?(:Admin).should be_true
       @user.has_role?(:god).should be_false
    end
  end
  
end