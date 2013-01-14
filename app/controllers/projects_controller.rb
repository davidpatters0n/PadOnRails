class ProjectsController < ApplicationController
  before_filter :authenticate, :only => [:index, :show, :new, :edit, :create, :update, :destroy]
  
   access_control do
    actions :index, :project_list, :new, :edit, :create, :update, :destroy, :show, :editTasks do
      allow :Admin
    end
    actions :index, :project_list, :editTasks, :edit, :update, :show do
      allow :BusinessManager
    end
  end
  # GET /projects
  # GET /projects.xml
  def index
    @title = "Project Management"
    
    if current_user.has_role?( :Admin ) || current_user.has_role?( :Corporate )
      @projects = Project.all
    else
      @projects = Project.find( :all, :conditions => [ "manager_user_id = ? OR account_manager = ?", current_user.id, current_user.id ] )
    end
    
    #view hours
    
    #get projects
    #@pro = Project.where(:manager_user_id => current_user.id )
    #@proa = Project.where(:account_manager => current_user.id)
    @pro = Project.where("manager_user_id = ? OR account_manager = ?", current_user.id, current_user.id)
    #@task = ProjectTask.where(:project_id => @pro.id)
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @title = @project.project_name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end
  
  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    
    0.times do
      project_task = @project.project_tasks.build
    end
    render :layout => false
  end
  
  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @title = "Edit " + @project.project_name
    
    @effort = Effort.all
    
  end
  
  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

      if @project.save
        task1 = ProjectTask.create!(:project_id => @project.id,
                                    :taskType => "Pre-Sales",
                                    :task_name => "Pre-Sales")
        task2 = ProjectTask.create!(:project_id => @project.id,
                                    :taskType => "Project",
                                    :task_name => "Project")
        task3 = ProjectTask.create!(:project_id => @project.id,
                                    :taskType => "Support",
                                    :task_name => "Support")
        task4 = ProjectTask.create!(:project_id => @project.id,
                                    :taskType => "Fault Fixing",
                                    :task_name => "Fault Fixing")
        task5 = ProjectTask.create!(:project_id => @project.id,
                                    :taskType => "Out-Of-Hours",
                                    :task_name => "Out-Of-Hours")
        flash[:notice] = "Successfully created project."
        redirect_to projects_path
      else
        render :action => 'new'
      end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
    #respond_to do |format|
      #if @project.update_attributes(params[:project])
        #format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
       # format.xml  { head :ok }
      #else
       # format.html { render :action => "edit" }
      #  format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
     # end
    #end
    
    if params[:manager_full_name]
      user = User.find_by_full_name( params[:manager_full_name] )
      if ! user.nil?
        params[ :project ][ :manager_user_id ] = user.id.to_s
      end
    end
        
    if params[:account_manager_full_name]
      user = User.find_by_full_name( params[:account_manager_full_name] )
      if ! user.nil?
        params[ :project ][ :account_manager ] = user.id.to_s
      end
    end
 
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated"
      redirect_to projects_url
    else
      flash[:warn] = @project.errors
      redirect_to edit_project_path(@project)
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
  
#  def project_list  
#    list=Project.all.map{|i|i.manager_user_id}
#    arr= [].concat(list.sort{|a,b| a[0]<=>b[0]}).to_json
 #   render :json =>arr
#  end

  def task_list
    @project = Project.find( params[:id] )
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def manager_list 
 
    SELECT u.full_name, project_name, task_name, hours
    FROM efforts 
    INNER JOIN project_tasks ON efforts.project_task_id = project_tasks.id 
    INNER JOIN projects ON project_tasks.project_id = projects.id 
    INNER JOIN users u ON efforts.user_id = u.id
    ORDER BY project_name 
    
    @user = current_user.id
    projectStuff = Project.where(:manager_user_id => @user)
    
   
  end
end
