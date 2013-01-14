class ContactsController < ApplicationController
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
    actions :index, :show, :new, :edit, :create, :update,:position_list,  :destroy do
      allow :Admin, :ProjectManager
    end
  end
  # GET /contacts
  # GET /contacts.xml
  def index
    @title = "Contacts"
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])
    @title = @contact.name
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @title = "Create a Contact"
    @contact = Contact.new
    render :layout => false
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    @title = "Edit " + @contact.name
  end
  
def position_list  
    matching_contacts = Contact.where(['position like ?', "#{params[:term]}%"])
    matching_positions = [].concat(matching_contacts.map(&:position).sort{|a,b| a[0]<=> b[0]}).to_json
    render :json => matching_positions 
  end
  

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

      if @contact.save
        flash[:success] = "Contact was successfully created."
        redirect_to crm_path
      else
        render :action => 'new'# Clear page
      end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

      if @contact.update_attributes(params[:contact])
        flash[:notice] = @contact.name + " was successfully updated."
        redirect_to crm_path
      else
        @title = "Edit " + @contact.name
        render 'edit'
      end
  end



  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    
    flash[:notice] = "Contact was successfully deleted."
    redirect_to crm_path
  end
end
