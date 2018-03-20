require "rails_helper"

RSpec.describe Admin::MaterialPurchasesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/material_purchases").to route_to("admin/material_purchases#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/material_purchases/new").to route_to("admin/material_purchases#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/material_purchases/1").to route_to("admin/material_purchases#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/material_purchases/1/edit").to route_to("admin/material_purchases#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/material_purchases").to route_to("admin/material_purchases#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/material_purchases/1").to route_to("admin/material_purchases#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/material_purchases/1").to route_to("admin/material_purchases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/material_purchases/1").to route_to("admin/material_purchases#destroy", :id => "1")
    end

  end
end
