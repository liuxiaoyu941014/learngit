require "rails_helper"

RSpec.describe Admin::DeliveriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/deliveries").to route_to("admin/deliveries#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/deliveries/new").to route_to("admin/deliveries#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/deliveries/1").to route_to("admin/deliveries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/deliveries/1/edit").to route_to("admin/deliveries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/deliveries").to route_to("admin/deliveries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/deliveries/1").to route_to("admin/deliveries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/deliveries/1").to route_to("admin/deliveries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/deliveries/1").to route_to("admin/deliveries#destroy", :id => "1")
    end

  end
end
