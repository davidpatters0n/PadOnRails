class TimesheetController < ApplicationController
  before_filter :authenticate, :only => [:index]
  before_filter :correct_user, :only => [:index]
  
  def index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    
    # Get the user from the URL, or default to the current logged in user
    if params[:id] == nil
      @user = current_user
    else
      @user = User.find_by_id(params[:id])

      # ensure the user_id exists
      if @user.nil?
        redirect_to( timesheet_path + "/" + current_user.id.to_s, :alert => "User #{params[:id]} does not exist" )
        @user = current_user
      end
    end
    
    @user_id = @user.id
        
    # Show user name in title if not viewing own timesheet
    @title = if current_user.id != @user.id
      "Timesheet - #{@user.full_name}"
    else
      "Timesheet"
    end
    
    @skipIt = false
    @date = Date.today.beginning_of_week.strftime( '%Y-%m-%d' )
    
    # The projects list should show the user's projects
    # If the user has no projects, show the full list
    @projects = @user.effort_projects
    @projects = Project.where( "id != 1" ) unless ! @projects.empty?
    
    # Get the week commencing from the URL params - if no param is set, assume the current week
    if params[:wc] == nil
      @week_commencing = Date.today.beginning_of_week.strftime( '%Y-%m-%d' )
    else
      @week_commencing = Date.strptime( params[:wc], "%Y-%m-%d" ).beginning_of_week.strftime( '%Y-%m-%d' )
    end
    
    # Get the effort records for the currently logged in user on the selected week
    @efforts = Effort.where( :user_id => @user_id, :week_commencing => @week_commencing )

    # Setup the special admin values
    @leave = @toil = @sick = 0
    @efforts.each do |effort|
      if( effort.project_task.project.id == 1 )
         @leave = effort.hours.to_i if effort.project_task.id == 1
         @toil = effort.hours.to_i if effort.project_task.id == 2
         @sick = effort.hours.to_i if effort.project_task.id == 3
      end
    end
    
    # Get a list of tasks recently used by the user
    recent_task_ids = Effort.all( :select => "project_task_id",
                                  :conditions => { :user_id => @user_id },
                                  :group => "project_task_id",
                                  :order => "MAX( week_commencing )" )

    # For each of the task ids, get the actual project task records
    @recent_tasks = []
    recent_task_ids.each do |effort|
      task = ProjectTask.find_by_id( effort.project_task_id )
      if task != nil && task.project_id != 1
        @recent_tasks.push( ProjectTask.find( effort.project_task_id ) )
      end
    end
    
    # Make a list of weeks with missing timesheet data
    effort_weeks = Effort.sum( :hours,
                               :conditions => { "user_id" => @user_id },
                               :group => "week_commencing" )
                               
    this_week = Date.today.beginning_of_week
    @missing_weeks = []
    12.times do
      this_week = this_week - 7
      week_ok = false
      
      # Now look for matching effort records
      effort_weeks.each do |wc, hours|
        if this_week == wc
          if hours >= 40
            week_ok = true
          end
        end
      end
      
      if ! week_ok
        @missing_weeks.push this_week.strftime( "%Y-%m-%d" )
      end
    end

  end

  # Shows a list of all projects in the project selector
  # NB AJAX only
  def showalltasks
    @projects = Project.where( "id != 1" )
    respond_to do |format|
      format.js 
    end
  end
  
  # Submits an effort entry from the timesheet system
  def submit
    
    # Get week commencing from URL, or default to the current week
    week_commencing = params[:week_commencing]
    if week_commencing == nil
      week_commencing = Date.today.beginning_of_week.strftime('%Y-%m-%d')
    end
    
    # Get user id from URL, or default to the current user
    if params[:user_id] == nil
      if current_user == nil
        redirect_to new_user_session_path
      else
        user_id = current_user.id
      end
    else
        #TODO add security here - only admins can do this...
        user_id = params[:user_id]
    end
    
    # check the task is a valid task
    project_task = ProjectTask.find_by_id( params[:task_id] )
    
    if project_task.nil?
      @flash = "Project Task Id #{params[:task_id]} not found"
      return
    end
    
    # compare efforts to current that wants to be submitted
    effort = Effort.all( :conditions => {
                         :user_id => params[:user_id],
                         :project_task_id => params[:task_id],
                         :week_commencing => params[:week_commencing] } )

    # Check whether this effort record already exists 
    if effort.any?
      
      # Exists - update the task's hours
      effort.first.hours = params[:hours]
      if !effort.first.hours.nil? && effort.first.hours > 0
        logger.info "Updating effort record " + effort.first.id.to_s
        Effort.update(effort.first.id, :hours => params[:hours])
        flash[:notice] = "Updated #{project_task.project.project_number} #{project_task.project.project_name} - #{project_task.task_name}"
      else
        logger.info "No hours - deleting effort record #{effort}"
        effort.first.delete
        flash[:notice] = "Deleted #{project_task.project.project_number} #{project_task.project.project_name} - #{project_task.task_name}"
      end
      
    else
      
      # No effort record exists - create it
      effort = Effort.new
      effort.user_id = user_id
      effort.project_task_id = params[:task_id]
      effort.week_commencing = params[:week_commencing]
      effort.hours = params[:hours]

      if !effort.hours.nil? && effort.hours > 0
        logger.info "No effort found - creating"
        effort.save
        
         # Create an entry in the users_projects table
         users_project = UsersProject.all( :conditions => { :user_id => user_id, :project_id => project_task.project_id } )
         unless users_project.any?
           users_project = UsersProject.new( :user_id => user_id, :project_id => project_task.project_id )
           if users_project.save
             flash[:notice] = "Added entry #{project_task.project.project_number} #{project_task.project.project_name} - #{project_task.task_name}"
           end
         end
      else
        logger.info "No info found - no hours to create"
      end
    end
    
    respond_to do |format|
      format.html
      format.js 
    end
  end
  
  
  def create
  end
  
  private
    
  def current_user?(user)
    user == current_user
  end
end
