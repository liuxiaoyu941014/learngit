require "rails_helper"

RSpec.describe Admin::MaterialStockAlertsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/material_stock_alerts").to route_to("admin/material_stock_alerts#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/material_stock_alerts/new").to route_to("admin/material_stock_alerts#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/material_stock_alerts/1").to route_to("admin/material_stock_alerts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/material_stock_alerts/1/edit").to route_to("admin/material_stock_alerts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/material_stock_alerts").to route_to("admin/material_stock_alerts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/material_stock_alerts/1").to route_to("admin/material_stock_alerts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/material_stock_alerts/1").to route_to("admin/material_stock_alerts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/material_stock_alerts/1").to route_to("admin/material_stock_alerts#destroy", :id => "1")
    end

  end
end
