require "spec_helper"

describe EffortsController do
  describe "routing" do

    it "routes to #index" do
      get("/efforts").should route_to("efforts#index")
    end

    it "routes to #new" do
      get("/efforts/new").should route_to("efforts#new")
    end

    it "routes to #show" do
      get("/efforts/1").should route_to("efforts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/efforts/1/edit").should route_to("efforts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/efforts").should route_to("efforts#create")
    end

    it "routes to #update" do
      put("/efforts/1").should route_to("efforts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/efforts/1").should route_to("efforts#destroy", :id => "1")
    end

  end
end
