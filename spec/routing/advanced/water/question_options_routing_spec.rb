require "spec_helper"

describe Advanced::Water::QuestionOptionsController do
  describe "routing" do

    it "routes to #index" do
      get("/advanced/waters").should route_to("advanced/waters#index")
    end

    it "routes to #new" do
      get("/advanced/waters/new").should route_to("advanced/waters#new")
    end

    it "routes to #show" do
      get("/advanced/waters/1").should route_to("advanced/waters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advanced/waters/1/edit").should route_to("advanced/waters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advanced/waters").should route_to("advanced/waters#create")
    end

    it "routes to #update" do
      put("/advanced/waters/1").should route_to("advanced/waters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advanced/waters/1").should route_to("advanced/waters#destroy", :id => "1")
    end

  end
end
