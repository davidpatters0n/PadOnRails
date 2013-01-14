class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :password, :show, :new, :create, :destroy]
  before_filter :correct_user, :only => [:edit, :change_password, :show]
  
  access_control do
    actions :password do
      allow all
    end
    actions :index, :edit, :update, :project_list,  :show, :change_password, :update_password do
      allow all
    end
    actions :new, :create, :destroy, :edit, :update, :editTasks, :show do
      allow :Admin
    end
  end

  def new
     @title = "Create a user"
     @user = User.new
     @roles = Role.all
     render :layout => false
  end
    
  def show
    if current_user.has_role? :Admin
      @title = "#{@user.full_name}'s Account"
    else
      @title = "My Account"
    end
    @user = User.find(params[:id])
    @users = User.all
    @roles = Role.all
    @projects = Project.all
    @efforts = Effort.all
    @users_projects = UsersProject.all
  end
  
  def index
   unless user_signed_in?
     redirect_to new_user_session_path
   end
   if user_signed_in?
    if current_user.has_role? :Admin
      redirect_to dashboard_path
    elsif current_user.has_role? :ProjectManager
      redirect_to dashboard_path
    else
      redirect_to timesheet_path + "/" + current_user.id.to_s
    end
   end
  end
  
  def edit
    @user = User.find(params[:id])
    @role = Role.all
    @roles = Role.all
    render :layout => false
  end

  def project_list  
    matching_users = User.where(['full_name like ?', "#{params[:term]}%"])
    matching_names = [].concat(matching_users.map(&:full_name).sort{|a,b| a[0]<=> b[0]}).to_json
    render :json => matching_names 
  end

  def update
    @user = User.find(params[:id])
    params[:user][:role_ids] ||= []
    @role = Role.all
    @roles = Role.all
    @current_password = params[:user].delete(:current_password)
    
    @user.update_attribute(:full_name, params[:user][:full_name])
    @user.update_attribute(:email, params[:user][:email])
    @user.update_attribute(:role_ids, params[:user][:role_ids])
    
    if current_user.has_role? :Admin
      flash[:success] = "User Updated."
      redirect_to user_path(@user)
    else
      flash[:success] = "Settings updated."
      redirect_to user_path(@user)
    end
  end
  
  def change_password
    @title = "Change your password"
    @user = User.find(params[:id])
    render :layout => false
  end
  
  def password
    @title = "Change your password"
    @user = User.find(params[:id])
    @role = Role.all
    @roles = Role.all
  end

  def update_password
    @user = current_user    
    @current_password = params[:user][:current_password]
    @password = params[:user][:password]
    
    if @user.valid_password?(@current_password)
      if @current_password == @password
        redirect_to user_path(@user)
        flash[:error] = "Current password cannot be the same as your new password."
      else
        if @user.update_attributes(params[:user])
          redirect_to login_path
          flash[:success] = "Password has been changed."
        else
          redirect_to user_path(@user)
          flash[:error] = "Didn't save contact an administrator."
        end
      end
    else
        redirect_to user_path(@user)
        flash[:error] = "Current password is incorrect."
    end
  end

  def create
    @title = "Create a user"
    @user = User.new(params[:user])
    @role = Role.all
    @roles = Role.all
    
    if @user.save
      redirect_to usermanagement_path
      flash[:success] = "Created successfully."
    else
      @title = "Create a user"
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.id == @user.id

      flash[:alert] = "You cannot delete your own user"

      redirect_to usermanagement_path
    else
      User.find(params[:id]).destroy
      flash[:success] = "#{@user.full_name} deleted."
      redirect_to usermanagement_path
    end
  end

  private
    
  def current_user?(user)
    user == current_user
  end
end
