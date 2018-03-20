require "rails_helper"

RSpec.describe Cms::CommentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms/comments").to route_to("cms/comments#index")
    end

    it "routes to #new" do
      expect(:get => "/cms/comments/new").to route_to("cms/comments#new")
    end

    it "routes to #show" do
      expect(:get => "/cms/comments/1").to route_to("cms/comments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms/comments/1/edit").to route_to("cms/comments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms/comments").to route_to("cms/comments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cms/comments/1").to route_to("cms/comments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cms/comments/1").to route_to("cms/comments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms/comments/1").to route_to("cms/comments#destroy", :id => "1")
    end

  end
end
