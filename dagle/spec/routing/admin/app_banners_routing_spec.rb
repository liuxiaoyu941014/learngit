require "rails_helper"

RSpec.describe Admin::AppBannersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/app_banners").to route_to("admin/app_banners#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/app_banners/new").to route_to("admin/app_banners#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/app_banners/1").to route_to("admin/app_banners#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/app_banners/1/edit").to route_to("admin/app_banners#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/app_banners").to route_to("admin/app_banners#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/app_banners/1").to route_to("admin/app_banners#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/app_banners/1").to route_to("admin/app_banners#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/app_banners/1").to route_to("admin/app_banners#destroy", :id => "1")
    end

  end
end
