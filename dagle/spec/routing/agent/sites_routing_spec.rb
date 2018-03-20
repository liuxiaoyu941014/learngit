require "rails_helper"

RSpec.describe Agent::SitesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agent/sites").to route_to("agent/sites#index")
    end

    it "routes to #new" do
      expect(:get => "/agent/sites/new").to route_to("agent/sites#new")
    end

    it "routes to #show" do
      expect(:get => "/agent/sites/1").to route_to("agent/sites#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agent/sites/1/edit").to route_to("agent/sites#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agent/sites").to route_to("agent/sites#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agent/sites/1").to route_to("agent/sites#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agent/sites/1").to route_to("agent/sites#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agent/sites/1").to route_to("agent/sites#destroy", :id => "1")
    end

  end
end
