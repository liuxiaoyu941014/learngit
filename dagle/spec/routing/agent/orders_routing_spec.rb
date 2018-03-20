require "rails_helper"

RSpec.describe Agent::OrdersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agent/orders").to route_to("agent/orders#index")
    end

    it "routes to #new" do
      expect(:get => "/agent/orders/new").to route_to("agent/orders#new")
    end

    it "routes to #show" do
      expect(:get => "/agent/orders/1").to route_to("agent/orders#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agent/orders/1/edit").to route_to("agent/orders#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agent/orders").to route_to("agent/orders#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agent/orders/1").to route_to("agent/orders#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agent/orders/1").to route_to("agent/orders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agent/orders/1").to route_to("agent/orders#destroy", :id => "1")
    end

  end
end
