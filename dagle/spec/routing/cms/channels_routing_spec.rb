require "rails_helper"

RSpec.describe Cms::ChannelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms/channels").to route_to("cms/channels#index")
    end

    it "routes to #new" do
      expect(:get => "/cms/channels/new").to route_to("cms/channels#new")
    end

    it "routes to #show" do
      expect(:get => "/cms/channels/1").to route_to("cms/channels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms/channels/1/edit").to route_to("cms/channels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms/channels").to route_to("cms/channels#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cms/channels/1").to route_to("cms/channels#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cms/channels/1").to route_to("cms/channels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms/channels/1").to route_to("cms/channels#destroy", :id => "1")
    end

  end
end
