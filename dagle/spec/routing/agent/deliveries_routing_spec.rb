require "rails_helper"

RSpec.describe Agent::DeliveriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agent/deliveries").to route_to("agent/deliveries#index")
    end

    it "routes to #new" do
      expect(:get => "/agent/deliveries/new").to route_to("agent/deliveries#new")
    end

    it "routes to #show" do
      expect(:get => "/agent/deliveries/1").to route_to("agent/deliveries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agent/deliveries/1/edit").to route_to("agent/deliveries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agent/deliveries").to route_to("agent/deliveries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agent/deliveries/1").to route_to("agent/deliveries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agent/deliveries/1").to route_to("agent/deliveries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agent/deliveries/1").to route_to("agent/deliveries#destroy", :id => "1")
    end

  end
end
