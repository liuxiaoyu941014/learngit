require "rails_helper"

RSpec.describe Cms::PagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms/pages").to route_to("cms/pages#index")
    end

    it "routes to #new" do
      expect(:get => "/cms/pages/new").to route_to("cms/pages#new")
    end

    it "routes to #show" do
      expect(:get => "/cms/pages/1").to route_to("cms/pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms/pages/1/edit").to route_to("cms/pages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms/pages").to route_to("cms/pages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cms/pages/1").to route_to("cms/pages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cms/pages/1").to route_to("cms/pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms/pages/1").to route_to("cms/pages#destroy", :id => "1")
    end

  end
end
