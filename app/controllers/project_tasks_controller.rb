class ProjectTasksController < ApplicationController
  before_filter :authenticate, :only => [:index, :show, :new, :edit, :create, :update, :destroy]
  layout Proc.new { |controller| controller.request.xhr?? false : 'application' }
  # GET /project_tasks
  # GET /project_tasks.xml
  
  access_control do
    actions :index, :addtimesheettask, :deletetimesheettask, :show, :new, :edit, :create, :update, :destroy do
      allow all
    end
  end
  
  def index
    @title = "Listing Project Tasks"
    # check if we've got a project id parameter
    if( params[:project_id].nil? )
      @project = nil
    else
      @project = Project.find(params[:project_id])
    end
    
    @user = current_user.id
    
    # if we found a project, show the tasks for the project, else show all tasks
    if @project.nil?
      @project_tasks = ProjectTask.all
    else
      @project_tasks = Project.find(params[:project_id]).project_tasks
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_tasks }
      format.js   # index.js.erb
    end
  end

  # GET /project_tasks/1
  # GET /project_tasks/1.xml
  def show
    @project_task = ProjectTask.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_task }
    end
  end

  # GET /addtimesheettask/1
  def addtimesheettask
    @project_task = ProjectTask.find(params[:id])

    respond_to do |format|
      format.js # addtimesheettask.html.erb
    end    
  end
  
  def deletetimesheettask
    @effort = Effort.find(params[:id])
    @effort.destroy
   
    respond_to do |format|
      format.html {redirect_to timesheet_path + "/" + current_user.id.to_s}
    end
  end
  
  # GET /project_tasks/new
  # GET /project_tasks/new.xml
  def new
    @title = "New Project Task"
    @project_task = ProjectTask.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_task }
    end
  end

  # GET /project_tasks/1/edit
  def edit
    @project_task = ProjectTask.find(params[:id])
  end

  # POST /project_tasks
  # POST /project_tasks.xml
  def create
    @project_task = ProjectTask.new(params[:project_task])

    respond_to do |format|
      if @project_task.save
        format.html { redirect_to(@project_task, :notice => 'Project task was successfully created.') }
        format.xml  { render :xml => @project_task, :status => :created, :location => @project_task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project_tasks/1
  # PUT /project_tasks/1.xml
  def update
    @project_task = ProjectTask.find(params[:id])

    respond_to do |format|
      if @project_task.update_attributes(params[:project_task])
        format.html { redirect_to(@project_task, :notice => 'Project task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_tasks/1
  # DELETE /project_tasks/1.xml
  def destroy
    @project_task = ProjectTask.find(params[:id])
    project = @project_task.project
    
    if @project_task.destroy
      respond_to do |format|
        format.html { redirect_to( edit_project_path(project), :notice => 'Project task was successfully deleted.' ) }
        format.xml  { head :ok }
      end
    end
  end
end
