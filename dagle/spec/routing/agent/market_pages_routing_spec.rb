require "rails_helper"

RSpec.describe Agent::MarketPagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agent/market_pages").to route_to("agent/market_pages#index")
    end

    it "routes to #new" do
      expect(:get => "/agent/market_pages/new").to route_to("agent/market_pages#new")
    end

    it "routes to #show" do
      expect(:get => "/agent/market_pages/1").to route_to("agent/market_pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agent/market_pages/1/edit").to route_to("agent/market_pages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agent/market_pages").to route_to("agent/market_pages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agent/market_pages/1").to route_to("agent/market_pages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agent/market_pages/1").to route_to("agent/market_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agent/market_pages/1").to route_to("agent/market_pages#destroy", :id => "1")
    end

  end
end
