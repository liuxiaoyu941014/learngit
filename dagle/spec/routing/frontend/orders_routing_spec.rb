require "rails_helper"

RSpec.describe Frontend::OrdersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/frontend/orders").to route_to("frontend/orders#index")
    end

    it "routes to #new" do
      expect(:get => "/frontend/orders/new").to route_to("frontend/orders#new")
    end

    it "routes to #show" do
      expect(:get => "/frontend/orders/1").to route_to("frontend/orders#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/frontend/orders/1/edit").to route_to("frontend/orders#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/frontend/orders").to route_to("frontend/orders#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/frontend/orders/1").to route_to("frontend/orders#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/frontend/orders/1").to route_to("frontend/orders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/frontend/orders/1").to route_to("frontend/orders#destroy", :id => "1")
    end

  end
end
