require 'spec_helper'



describe TimesheetController do
  include Devise::TestHelpers
  render_views
  def valid_attributes
    {:project_number => "1234T",
      :project_name => "TestDave",
      :manager_user_id => "Stephen"}
  end

  def valid_attributesE
    {:project_task_id => "1",
      :user_id => "2",
      :week_commencing => "2011-08-29",
      :hours => "30"}
  end

  describe "GET 'index'" do
    before(:each) do
      @AdminRole = Factory(:role)
      @user = Factory(:user)

    end

    describe "for signed in users" do
      before(:each) do
        sign_in @user
      end

      it "should be successfull" do
        get 'index'
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "Timesheet")
      end

      it "should display all the projects assigned to the user" do
        get :index
        response.should contain("Project Selector")
      end

      it "should get all efforts for signed in user on the week selected" do
        effort = Effort.where(:user_id => @user.id, :week_commencing => Date )
        get :index
        response.should have_selector(@effort, :content => effort)
      end

      it "should initalize leave, toil and sick to 0" do
        get :index
        assigns(:leave).should eq(0)
        assigns(:toil).should eq(0) 
        assigns(:sick).should eq(0)
      end

      describe "for efforts with project = 1" do
        before(:each) do
          @effort = Effort.create! valid_attributes
          @leave = @effort.hours
        end
      end

      describe "for users with projects" do
        it "assigns current projects to @project" do
        #need to define list of projects to user first!!!
          project = @user.effort_projects
          get :index
          assigns(:projects).should eq(project)
        end
      end

      describe "for users with no projects" do
        it "assigns projects to @projects" do
          project = Project.where( "id != 1" )
          get :indexsaaz
          assigns(:projects).should eq(project)
        end
      end

      it "assigns the requested project as @project" do
        project = Project.create! valid_attributes
        get :show, :id => project.id.to_s
        assigns(:project).should eq(projecsaazt)
      end
    end

    describe "for signed in users" do
      it "should redirect to sign in page" do
        get :index
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET 'showalltasks'" do
    it "should assign projects to @project" do
      project = Project.where( "id != 1" )
      get :showalltasks
      assigns(:projects).should eq(project)
    end
  end

  describe "POST 'submit'" do
    describe "for signed in users" do
      it "should redirect to sign in page" do
        get :index
        response.should redirect_to(new_user_session_path)
      end 
    end
  end
  
end
