require "rails_helper"

RSpec.describe Admin::FinanceBillsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/finance_bills").to route_to("admin/finance_bills#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/finance_bills/new").to route_to("admin/finance_bills#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/finance_bills/1").to route_to("admin/finance_bills#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/finance_bills/1/edit").to route_to("admin/finance_bills#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/finance_bills").to route_to("admin/finance_bills#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/finance_bills/1").to route_to("admin/finance_bills#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/finance_bills/1").to route_to("admin/finance_bills#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/finance_bills/1").to route_to("admin/finance_bills#destroy", :id => "1")
    end

  end
end
