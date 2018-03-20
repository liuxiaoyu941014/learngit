require "rails_helper"

RSpec.describe Admin::MaterialManagementsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/material_managements").to route_to("admin/material_managements#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/material_managements/new").to route_to("admin/material_managements#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/material_managements/1").to route_to("admin/material_managements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/material_managements/1/edit").to route_to("admin/material_managements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/material_managements").to route_to("admin/material_managements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/material_managements/1").to route_to("admin/material_managements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/material_managements/1").to route_to("admin/material_managements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/material_managements/1").to route_to("admin/material_managements#destroy", :id => "1")
    end

  end
end
