class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from 'Acl9::AccessDenied', :with => :access_denied
    
    private
    def access_denied
      if current_user
          redirect_to timesheet_path + "/" + current_user.id.to_s
          flash[:notice] = 'You do not have the privileges.'
      else
          redirect_to login_path
          flash[:notice] = 'Access denied. Try to log in first.'
      end
    end   
    
    def authenticate
      access_denied unless signed_in?
    end
    
    def correct_user
      if !params[:id].nil?
        @user = User.find_by_id( params[:id] )
        if current_user.has_role? :Admin
          #Allow them to access everyones page
          #Whoever is not allowed to access add them to the IF statement
        else
          access_denied unless current_user?(@user)
        end
      end
    end
end
