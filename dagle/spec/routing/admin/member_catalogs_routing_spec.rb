require "rails_helper"

RSpec.describe Admin::MemberCatalogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/member_catalogs").to route_to("admin/member_catalogs#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/member_catalogs/new").to route_to("admin/member_catalogs#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/member_catalogs/1").to route_to("admin/member_catalogs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/member_catalogs/1/edit").to route_to("admin/member_catalogs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/member_catalogs").to route_to("admin/member_catalogs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/member_catalogs/1").to route_to("admin/member_catalogs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/member_catalogs/1").to route_to("admin/member_catalogs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/member_catalogs/1").to route_to("admin/member_catalogs#destroy", :id => "1")
    end

  end
end
