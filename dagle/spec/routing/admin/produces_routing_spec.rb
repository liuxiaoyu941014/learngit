require "rails_helper"

RSpec.describe Admin::ProducesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/produces").to route_to("admin/produces#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/produces/new").to route_to("admin/produces#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/produces/1").to route_to("admin/produces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/produces/1/edit").to route_to("admin/produces#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/produces").to route_to("admin/produces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/produces/1").to route_to("admin/produces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/produces/1").to route_to("admin/produces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/produces/1").to route_to("admin/produces#destroy", :id => "1")
    end

  end
end
