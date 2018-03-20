require "rails_helper"

RSpec.describe Admin::FinanceHistoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/finance_histories").to route_to("admin/finance_histories#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/finance_histories/new").to route_to("admin/finance_histories#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/finance_histories/1").to route_to("admin/finance_histories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/finance_histories/1/edit").to route_to("admin/finance_histories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/finance_histories").to route_to("admin/finance_histories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/finance_histories/1").to route_to("admin/finance_histories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/finance_histories/1").to route_to("admin/finance_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/finance_histories/1").to route_to("admin/finance_histories#destroy", :id => "1")
    end

  end
end
