require "rails_helper"

RSpec.describe Admin::StaffsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/staffs").to route_to("admin/staffs#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/staffs/new").to route_to("admin/staffs#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/staffs/1").to route_to("admin/staffs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/staffs/1/edit").to route_to("admin/staffs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/staffs").to route_to("admin/staffs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/staffs/1").to route_to("admin/staffs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/staffs/1").to route_to("admin/staffs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/staffs/1").to route_to("admin/staffs#destroy", :id => "1")
    end

  end
end
