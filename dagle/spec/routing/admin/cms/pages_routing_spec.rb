require "rails_helper"

RSpec.describe Admin::Cms::PagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/cms").to route_to("admin/cms#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/cms/new").to route_to("admin/cms#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/cms/1").to route_to("admin/cms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/cms/1/edit").to route_to("admin/cms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/cms").to route_to("admin/cms#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/cms/1").to route_to("admin/cms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/cms/1").to route_to("admin/cms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/cms/1").to route_to("admin/cms#destroy", :id => "1")
    end

  end
end
