require "rails_helper"

RSpec.describe Admin::Forage::SimplesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/forages").to route_to("admin/forages#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/forages/new").to route_to("admin/forages#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/forages/1").to route_to("admin/forages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/forages/1/edit").to route_to("admin/forages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/forages").to route_to("admin/forages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/forages/1").to route_to("admin/forages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/forages/1").to route_to("admin/forages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/forages/1").to route_to("admin/forages#destroy", :id => "1")
    end

  end
end
