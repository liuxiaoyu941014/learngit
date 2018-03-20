require "rails_helper"

RSpec.describe Admin::MarketCatalogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/market_catalogs").to route_to("admin/market_catalogs#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/market_catalogs/new").to route_to("admin/market_catalogs#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/market_catalogs/1").to route_to("admin/market_catalogs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/market_catalogs/1/edit").to route_to("admin/market_catalogs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/market_catalogs").to route_to("admin/market_catalogs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/market_catalogs/1").to route_to("admin/market_catalogs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/market_catalogs/1").to route_to("admin/market_catalogs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/market_catalogs/1").to route_to("admin/market_catalogs#destroy", :id => "1")
    end

  end
end
