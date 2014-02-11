require "spec_helper"

describe MlogEntriesController do
  describe "routing" do

    it "routes to #index" do
      get("/mlog_entries").should route_to("mlog_entries#index")
    end

    it "routes to #new" do
      get("/mlog_entries/new").should route_to("mlog_entries#new")
    end

    it "routes to #show" do
      get("/mlog_entries/1").should route_to("mlog_entries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mlog_entries/1/edit").should route_to("mlog_entries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mlog_entries").should route_to("mlog_entries#create")
    end

    it "routes to #update" do
      put("/mlog_entries/1").should route_to("mlog_entries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mlog_entries/1").should route_to("mlog_entries#destroy", :id => "1")
    end

  end
end
