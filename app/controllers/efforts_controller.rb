class EffortsController < ApplicationController
before_filter :authenticate, :only => [:index, :show, :new, :edit, :create, :update, :destroy]
  # GET /efforts
  # GET /efforts.xml
  def index
    @efforts = Effort.all
    @effort_array = @efforts.sort{|a,b| a.week_commencing <=> b.week_commencing } 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @efforts }
    end
  end

  # GET /efforts/1
  # GET /efforts/1.xml
  def show
    @effort = Effort.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @effort }
    end
  end

  # GET /efforts/new
  # GET /efforts/new.xml
  def new
    @effort = Effort.new

    redirect_to timesheet_path + "/" + current_user.id.to_s
  end

  # GET /efforts/1/edit
  def edit
    @effort = Effort.find(params[:id])
  end

  # POST /efforts
  # POST /efforts.xml
  def create
    @effort = Effort.new(params[:effort])

    respond_to do |format|
      if @effort.save
        format.html { redirect_to(@effort, :notice => 'Effort was successfully created.') }
        format.xml  { render :xml => @effort, :status => :created, :location => @effort }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @effort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /efforts/1
  # PUT /efforts/1.xml
  def update
    @effort = Effort.find(params[:id])

    respond_to do |format|
      if @effort.update_attributes(params[:effort])
        format.html { redirect_to(@effort, :notice => 'Effort was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @effort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /efforts/1
  # DELETE /efforts/1.xml
  def destroy
    @effort = Effort.find(params[:id])
    @effort.destroy
   
    respond_to do |format|
      format.html {redirect_to timesheet_path + "/" + current_user.id.to_s}
    end
  end 
end
