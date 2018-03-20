require "rails_helper"

RSpec.describe Admin::CatalogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/catalogs").to route_to("admin/catalogs#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/catalogs/new").to route_to("admin/catalogs#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/catalogs/1").to route_to("admin/catalogs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/catalogs/1/edit").to route_to("admin/catalogs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/catalogs").to route_to("admin/catalogs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/catalogs/1").to route_to("admin/catalogs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/catalogs/1").to route_to("admin/catalogs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/catalogs/1").to route_to("admin/catalogs#destroy", :id => "1")
    end

  end
end
