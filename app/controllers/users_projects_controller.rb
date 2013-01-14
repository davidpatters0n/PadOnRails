class UsersProjectsController < ApplicationController
before_filter :authenticate, :only => [:index, :selector, :choose, :show, :new, :edit, :create, :update, :destroy, :submit]
  # GET /users_projects
  # GET /users_projects.xml
  def index
    @users_projects = UsersProject.where(:user_id => current_user.id)
    @projects = Project.all
    @users_project = UsersProject.new
    @array = Array.new
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users_projects }
    end
  end
  
  # GET /users_projects/selector
  def selector
    @users_projects = UsersProject.where( "user_id = ? and project_id != ?", current_user.id, 1 )
    @projects = Project.all
    
    respond_to do |format|
      format.html # selector.html.erb
    end
  end

  # POST /users_projects/selector
  def choose
    # first delete the existing users_projects records for the current user
    UsersProject.where( :user_id => current_user.id ).each do |userproj|
      userproj.destroy
    end

    # Now create the users_projects records that were submitted
    if !params[:projects].nil?
      params[:projects].each do |project|
        @users_project = UsersProject.create!( :user_id => current_user.id, :project_id => project )
      end
    end
    
    # Go back to the timesheet
    respond_to do |format|
      format.html { redirect_to(timesheet_path + "/6", :notice => "Favourite projects updated") }
    end
  end
  
  
  # GET /users_projects/1
  # GET /users_projects/1.xml
  def show
    @users_projects = UsersProject.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @users_projects }
    end
  end

  # GET /users_projects/new
  # GET /users_projects/new.xml
  def new
    @users_project = UsersProject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users_project }
    end
  end

  # GET /users_projects/1/edit
  def edit
    @users_project = UsersProject.find(params[:id])
  end

  # POST /users_projects
  # POST /users_projects.xml
  def create
    @users_project = UsersProject.new(params[:users_project])

    respond_to do |format|
      if @users_project.save
        format.html { redirect_to(@users_project, :notice => 'Users project was successfully created.') }
        format.xml  { render :xml => @users_project, :status => :created, :location => @users_project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @users_project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users_projects/1
  # PUT /users_projects/1.xml
  def update
    @users_project = UsersProject.find(params[:id])

    respond_to do |format|
      if @users_project.update_attributes(params[:users_project])
        format.html { redirect_to(@users_project, :notice => 'Users project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @users_project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users_projects/1
  # DELETE /users_projects/1.xml
  def destroy
    @users_project = UsersProject.find(params[:id])
    @users_project.destroy

    respond_to do |format|
      format.html { redirect_to(users_projects_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def submit
    
    project = Project.find_by_id( params[:project_id])
    
    if project.nil?
      @flash = "Project Id #{params[:project_id]} not found"
      return
    end
    
    up = UsersProject.all( :conditions => {
                           :user_id => params[:user_id],
                           :project_id => params[:project_id] })
    
    if up.any?
      #if exists dont do anything and skip
    else
      #exists
      up = UsersProject.new
      up.user_id = params[:user_id]
      up.project_id = params[:project_id]
      
      logger.info "No users projects found - creating"
      if up.save
        flash[:notice] = "Updated"
      end
    end        
    
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
