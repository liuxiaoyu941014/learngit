require "rails_helper"

RSpec.describe Admin::OrderMaterialsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/order_materials").to route_to("admin/order_materials#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/order_materials/new").to route_to("admin/order_materials#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/order_materials/1").to route_to("admin/order_materials#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/order_materials/1/edit").to route_to("admin/order_materials#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/order_materials").to route_to("admin/order_materials#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/order_materials/1").to route_to("admin/order_materials#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/order_materials/1").to route_to("admin/order_materials#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/order_materials/1").to route_to("admin/order_materials#destroy", :id => "1")
    end

  end
end
