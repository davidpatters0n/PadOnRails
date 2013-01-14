class DashboardController < ApplicationController
  before_filter :authenticate, :only => [:index]

  access_control do
    actions :index do
      allow :Admin, :ProjectManager
    end
  end

  def index
    @title = "Dashboard"
  end
end