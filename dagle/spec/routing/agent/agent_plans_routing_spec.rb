require "rails_helper"

RSpec.describe Agent::AgentPlansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agent/agent_plans").to route_to("agent/agent_plans#index")
    end

    it "routes to #new" do
      expect(:get => "/agent/agent_plans/new").to route_to("agent/agent_plans#new")
    end

    it "routes to #show" do
      expect(:get => "/agent/agent_plans/1").to route_to("agent/agent_plans#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agent/agent_plans/1/edit").to route_to("agent/agent_plans#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agent/agent_plans").to route_to("agent/agent_plans#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agent/agent_plans/1").to route_to("agent/agent_plans#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agent/agent_plans/1").to route_to("agent/agent_plans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agent/agent_plans/1").to route_to("agent/agent_plans#destroy", :id => "1")
    end

  end
end
