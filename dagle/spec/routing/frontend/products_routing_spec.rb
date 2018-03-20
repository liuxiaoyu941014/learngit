require "rails_helper"

RSpec.describe Frontend::ProductsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/frontend/products").to route_to("frontend/products#index")
    end

    it "routes to #new" do
      expect(:get => "/frontend/products/new").to route_to("frontend/products#new")
    end

    it "routes to #show" do
      expect(:get => "/frontend/products/1").to route_to("frontend/products#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/frontend/products/1/edit").to route_to("frontend/products#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/frontend/products").to route_to("frontend/products#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/frontend/products/1").to route_to("frontend/products#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/frontend/products/1").to route_to("frontend/products#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/frontend/products/1").to route_to("frontend/products#destroy", :id => "1")
    end

  end
end
