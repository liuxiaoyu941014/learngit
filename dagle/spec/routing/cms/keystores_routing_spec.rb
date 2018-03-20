require "rails_helper"

RSpec.describe Cms::KeystoresController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms/keystores").to route_to("cms/keystores#index")
    end

    it "routes to #new" do
      expect(:get => "/cms/keystores/new").to route_to("cms/keystores#new")
    end

    it "routes to #show" do
      expect(:get => "/cms/keystores/1").to route_to("cms/keystores#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms/keystores/1/edit").to route_to("cms/keystores#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms/keystores").to route_to("cms/keystores#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cms/keystores/1").to route_to("cms/keystores#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cms/keystores/1").to route_to("cms/keystores#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms/keystores/1").to route_to("cms/keystores#destroy", :id => "1")
    end

  end
end
