require "rails_helper"

RSpec.describe Admin::MarketPagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/market_pages").to route_to("admin/market_pages#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/market_pages/new").to route_to("admin/market_pages#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/market_pages/1").to route_to("admin/market_pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/market_pages/1/edit").to route_to("admin/market_pages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/market_pages").to route_to("admin/market_pages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/market_pages/1").to route_to("admin/market_pages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/market_pages/1").to route_to("admin/market_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/market_pages/1").to route_to("admin/market_pages#destroy", :id => "1")
    end

  end
end
