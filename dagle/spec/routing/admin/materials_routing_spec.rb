require "rails_helper"

RSpec.describe Admin::MaterialsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/materials").to route_to("admin/materials#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/materials/new").to route_to("admin/materials#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/materials/1").to route_to("admin/materials#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/materials/1/edit").to route_to("admin/materials#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/materials").to route_to("admin/materials#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/materials/1").to route_to("admin/materials#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/materials/1").to route_to("admin/materials#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/materials/1").to route_to("admin/materials#destroy", :id => "1")
    end

  end
end
