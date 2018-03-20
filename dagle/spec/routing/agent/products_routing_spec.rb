require "rails_helper"

RSpec.describe Agent::ProductsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agent/products").to route_to("agent/products#index")
    end

    it "routes to #new" do
      expect(:get => "/agent/products/new").to route_to("agent/products#new")
    end

    it "routes to #show" do
      expect(:get => "/agent/products/1").to route_to("agent/products#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agent/products/1/edit").to route_to("agent/products#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agent/products").to route_to("agent/products#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agent/products/1").to route_to("agent/products#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agent/products/1").to route_to("agent/products#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agent/products/1").to route_to("agent/products#destroy", :id => "1")
    end

  end
end
