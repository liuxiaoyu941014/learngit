require "rails_helper"

RSpec.describe Cms::SitesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms/sites").to route_to("cms/sites#index")
    end

    it "routes to #new" do
      expect(:get => "/cms/sites/new").to route_to("cms/sites#new")
    end

    it "routes to #show" do
      expect(:get => "/cms/sites/1").to route_to("cms/sites#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms/sites/1/edit").to route_to("cms/sites#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms/sites").to route_to("cms/sites#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cms/sites/1").to route_to("cms/sites#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cms/sites/1").to route_to("cms/sites#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms/sites/1").to route_to("cms/sites#destroy", :id => "1")
    end

  end
end
