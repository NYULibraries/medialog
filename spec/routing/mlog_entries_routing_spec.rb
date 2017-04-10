require "spec_helper"

describe MlogEntriesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/mlog_entries")).to route_to("mlog_entries#index")
    end

    it "routes to #new" do
      expect(get("/mlog_entries/new")).to route_to("mlog_entries#new")
    end

    it "routes to #show" do
      expect(get("/mlog_entries/1")).to route_to("mlog_entries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/mlog_entries/1/edit")).to route_to("mlog_entries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/mlog_entries")).to route_to("mlog_entries#create")
    end

    it "routes to #update" do
      expect(put("/mlog_entries/1")).to route_to("mlog_entries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/mlog_entries/1")).to route_to("mlog_entries#destroy", :id => "1")
    end

  end
end
