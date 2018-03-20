require "rails_helper"

RSpec.describe Admin::MaterialManagementHistoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/material_management_histories").to route_to("admin/material_management_histories#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/material_management_histories/new").to route_to("admin/material_management_histories#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/material_management_histories/1").to route_to("admin/material_management_histories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/material_management_histories/1/edit").to route_to("admin/material_management_histories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/material_management_histories").to route_to("admin/material_management_histories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/material_management_histories/1").to route_to("admin/material_management_histories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/material_management_histories/1").to route_to("admin/material_management_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/material_management_histories/1").to route_to("admin/material_management_histories#destroy", :id => "1")
    end

  end
end
