require "spec_helper"

describe ProjectTasksController do
  describe "routing" do

    it "routes to #index" do
      get("/project_tasks").should route_to("project_tasks#index")
    end

    it "routes to #new" do
      get("/project_tasks/new").should route_to("project_tasks#new")
    end

    it "routes to #show" do
      get("/project_tasks/1").should route_to("project_tasks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/project_tasks/1/edit").should route_to("project_tasks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/project_tasks").should route_to("project_tasks#create")
    end

    it "routes to #update" do
      put("/project_tasks/1").should route_to("project_tasks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/project_tasks/1").should route_to("project_tasks#destroy", :id => "1")
    end

  end
end
