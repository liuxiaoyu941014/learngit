require "rails_helper"

RSpec.describe Admin::CatalogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/material_catalogs").to route_to("admin/catalogs#index", klass: 'MaterialCatalog')
    end

    it "routes to #new" do
      expect(:get => "/admin/material_catalogs/new").to route_to("admin/catalogs#new", klass: 'MaterialCatalog')
    end

    it "routes to #show" do
      expect(:get => "/admin/material_catalogs/1").to route_to("admin/catalogs#show", klass: 'MaterialCatalog', :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/material_catalogs/1/edit").to route_to("admin/catalogs#edit", klass: 'MaterialCatalog', :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/material_catalogs").to route_to("admin/catalogs#create", klass: 'MaterialCatalog')
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/material_catalogs/1").to route_to("admin/catalogs#update", klass: 'MaterialCatalog', :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/material_catalogs/1").to route_to("admin/catalogs#update", klass: 'MaterialCatalog', :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/material_catalogs/1").to route_to("admin/catalogs#destroy", klass: 'MaterialCatalog', :id => "1")
    end

  end
end
