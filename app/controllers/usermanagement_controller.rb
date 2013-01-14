class UsermanagementController < ApplicationController
  before_filter :authenticate, :only => [:index]
  
  access_control do
    actions :index do
      allow :Admin
    end
  end
  
  def index
    @title = "User Management"
    @users = User.all
    @roles = Role.all
  end
end