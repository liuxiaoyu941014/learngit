require "rails_helper"

RSpec.describe Agent::PreorderConversitionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agent/preorder_conversitions").to route_to("agent/preorder_conversitions#index")
    end

    it "routes to #new" do
      expect(:get => "/agent/preorder_conversitions/new").to route_to("agent/preorder_conversitions#new")
    end

    it "routes to #show" do
      expect(:get => "/agent/preorder_conversitions/1").to route_to("agent/preorder_conversitions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agent/preorder_conversitions/1/edit").to route_to("agent/preorder_conversitions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agent/preorder_conversitions").to route_to("agent/preorder_conversitions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agent/preorder_conversitions/1").to route_to("agent/preorder_conversitions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agent/preorder_conversitions/1").to route_to("agent/preorder_conversitions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agent/preorder_conversitions/1").to route_to("agent/preorder_conversitions#destroy", :id => "1")
    end

  end
end
