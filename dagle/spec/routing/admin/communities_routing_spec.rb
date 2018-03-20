require "rails_helper"

RSpec.describe Admin::CommunitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/communities").to route_to("admin/communities#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/communities/new").to route_to("admin/communities#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/communities/1").to route_to("admin/communities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/communities/1/edit").to route_to("admin/communities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/communities").to route_to("admin/communities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/communities/1").to route_to("admin/communities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/communities/1").to route_to("admin/communities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/communities/1").to route_to("admin/communities#destroy", :id => "1")
    end

  end
end
