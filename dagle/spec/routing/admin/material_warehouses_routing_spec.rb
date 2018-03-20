require "rails_helper"

RSpec.describe Admin::MaterialWarehousesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/material_warehouses").to route_to("admin/material_warehouses#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/material_warehouses/new").to route_to("admin/material_warehouses#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/material_warehouses/1").to route_to("admin/material_warehouses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/material_warehouses/1/edit").to route_to("admin/material_warehouses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/material_warehouses").to route_to("admin/material_warehouses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/material_warehouses/1").to route_to("admin/material_warehouses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/material_warehouses/1").to route_to("admin/material_warehouses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/material_warehouses/1").to route_to("admin/material_warehouses#destroy", :id => "1")
    end

  end
end
