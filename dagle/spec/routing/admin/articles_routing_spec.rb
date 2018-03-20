require "rails_helper"

RSpec.describe Admin::ArticlesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/articles").to route_to("admin/articles#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/articles/new").to route_to("admin/articles#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/articles/1").to route_to("admin/articles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/articles/1/edit").to route_to("admin/articles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/articles").to route_to("admin/articles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/articles/1").to route_to("admin/articles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/articles/1").to route_to("admin/articles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/articles/1").to route_to("admin/articles#destroy", :id => "1")
    end

  end
end
