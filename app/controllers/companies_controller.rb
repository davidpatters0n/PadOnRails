class CompaniesController < ApplicationController
  before_filter :authenticate, :only => [:index,:show,:new,:edit,:create,:update,:destroy]
  uses_tiny_mce :options => {
                            :theme => 'advanced',
                            :mode => "textareas",
                            :theme_advanced_buttons1 => "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect",
                            :theme_advanced_buttons2 => "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
                            :theme_advanced_buttons3 => "hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr",
                            :theme_advanced_toolbar_location => "top",
                            :theme_advanced_toolbar_align => "left",
                            :theme_advanced_statusbar_location => "bottom",
                            :theme_advanced_resizing => true
                          }
  access_control do
    actions :index, :show, :new, :edit, :create, :update, :destroy do
      allow :Admin, :ProjectManager
    end
  end
  # GET /companies
  # GET /companies.xml
  def index
    @title = "Customer Relation Management"
    @companies = Company.all
    @contacts = Contact.all
	@opportunities = Opportunity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])
    @title = @company.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end
  
  #
  # GET /companies/new
  # GET /companies/new.xml
  def new
    @title = "Create a Company"
    @company = Company.new
    render :layout => false
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    @title = "Edit " + @company.name
  end

  # POST /companies
  # POST /companies.xml
  
  def create
    @company = Company.new(params[:company])

      if @company.save
        flash[:success] = "Company was successfully created."
        redirect_to crm_path
      else
        render :action => 'new'# Clear page
      end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])

      if @company.update_attributes(params[:company])
        flash[:success] = @company.name + " was successfully updated."
        redirect_to crm_path
      else
        @title = "Edit " + @company.name
        render 'edit'
      end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    flash[:success] = "Company was successfully deleted."
    redirect_to crm_path
  end
end
