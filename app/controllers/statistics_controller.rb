class StatisticsController < ApplicationController

  before_filter :authenticate, :only => [:index, :projectstats, :range]

  access_control do

    actions :taskTypeToIndex, :projectstats, :range, :presales, :get_time_entries do
    allow :Admin, :ProjectManager, :Corporate
    end
    actions :index do
      allow all
    end
  end

  def index

    @title = "Statistics"

    @projects = Project.all

    @users_projects = UsersProject.all

    @user = current_user

    @data = []

    if (current_user.id == 6)

    @pro = Project.where("project_name != ?", "ADMIN")

    else

    @pro = Project.where("manager_user_id = ? OR account_manager = ?", current_user.id, current_user.id)

    end

    Project.all.each do |project|

      projdata = { :name   => project.project_name.to_s,

        :values => [] }

      ['Pre-Sales','Project','Fault Fixing','Support','Out Of Hours'].each do |taskname|

        record = Effort.sum( :hours,

        :joins => :project_task,

        :conditions => { "project_tasks.project_id" => project.id,

          "project_tasks.task_name" => taskname,

          "User_id" => current_user.id} )

        projdata[ :values ].push( record )

      end

      @data.push( projdata )

    end

  end

  def taskTypeToIndex( type )

    case type

    when 'Pre-Sales'

      0

    when 'Project'

      1

    when 'Fault Fixing'

      2

    when 'Support'

      3

    when 'Out Of Hours'

      4

    when 'Sick'

      0

    when 'Toil'

      0

    when 'Leave'

      0

    else

    0

    end

  end

  def projectstats

    @title = "Project Statistics"

    @projects = Project.all

    @data = []
    @user = User.find(params[:id])
    @users = User.all
    @project = Project.find(params[:id])
    @project_tasks = Project.find(params[:id]).project_tasks
    @project_task = ProjectTask.find(params[:id])
    @progressStr = ""

    if (current_user.id == 6)

    @pro = Project.where("project_name != ?", "ADMIN")

    else

    @pro = Project.where("manager_user_id = ? OR account_manager = ?", current_user.id, current_user.id)

    end

    projdata = { :name => '', :values => [0,0,0,0,0] }

    @records = Effort.joins( :project_task, :user ).

    where( 'project_tasks.project_id' => params[:id] ).

    group( :full_name, :taskType ).

    order( :full_name ).

    sum( :hours )

    @records.each do | ( full_name, taskType ), hours |

      if full_name != projdata[ :name ]

        if projdata[ :name ] != ''

        @data.push( projdata )

        end

        @progressStr = @progressStr + "<br>Found new project: #{full_name}<br>"

        projdata = { :name => full_name, :values => [0,0,0,0,0] }

      end

      projdata[ :values ][ taskTypeToIndex( taskType ) ] += Integer( hours );

    end

    if projdata[ :name ] != ''

    @data.push( projdata )

    end

  end

  def range

    @title = "Statistics"

    @projects = Project.all

    @efforts = Effort.all

    @users_projects = UsersProject.all

    @effort_array = @efforts.sort{|a,b| a.week_commencing <=> b.week_commencing }

    @user = current_user

    @data = []

    @pro = Project.where("manager_user_id = ? OR account_manager = ?", current_user.id, current_user.id)

    Project.all.each do |project|

      projdata = { :name   => project.project_name.to_s,

        :values => [] }

      ['Pre-Sales','Project','Fault Fixing','Support','Out Of Hours'].each do |taskname|

        record = Effort.sum( :hours,

        :joins => :project_task,

        :conditions => { "project_tasks.project_id" => project.id,

          "project_tasks.task_name" => taskname} )

        projdata[ :values ].push( record )

      end

      @data.push( projdata )

    end

  end

  def get_time_entries
    @data = []

    Project.all.each do |project|
      projdata = { 
        :name   => project.project_name.to_s,
        :data => [] 
      }

      ['Pre-Sales','Project','Fault Fixing','Support','Out Of Hours'].each do |taskname|
        record = Effort.sum(
          :hours,
          :joins => :project_task,
          :conditions => [
            "project_tasks.project_id = ? AND project_tasks.task_name = ? AND user_id = ? AND week_commencing >= ? AND week_commencing <= ?",
            project.id, 
            taskname,
            params[:user_id],
            params[:from],
            params[:to]
          ]
        )

        projdata[ :data ].push( record )
      end

      @data.push( projdata ) unless (projdata[:data].reduce(0) {|sum,x| sum+=x}.to_i) == 0

    end

    respond_to do |format|
      format.json { render :json => @data.to_json }
    end
  end
  

end
