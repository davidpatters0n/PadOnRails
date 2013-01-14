require "spec_helper"

describe UsersProjectsController do
  describe "routing" do

    it "routes to #index" do
      get("/users_projects").should route_to("users_projects#index")
    end

    it "routes to #new" do
      get("/users_projects/new").should route_to("users_projects#new")
    end

    it "routes to #show" do
      get("/users_projects/1").should route_to("users_projects#show", :id => "1")
    end

    it "routes to #edit" do
      get("/users_projects/1/edit").should route_to("users_projects#edit", :id => "1")
    end

    it "routes to #create" do
      post("/users_projects").should route_to("users_projects#create")
    end

    it "routes to #update" do
      put("/users_projects/1").should route_to("users_projects#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/users_projects/1").should route_to("users_projects#destroy", :id => "1")
    end

  end
end
