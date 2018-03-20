require "rails_helper"

RSpec.describe Admin::AddressBooksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/address_books").to route_to("admin/address_books#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/address_books/new").to route_to("admin/address_books#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/address_books/1").to route_to("admin/address_books#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/address_books/1/edit").to route_to("admin/address_books#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/address_books").to route_to("admin/address_books#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/address_books/1").to route_to("admin/address_books#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/address_books/1").to route_to("admin/address_books#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/address_books/1").to route_to("admin/address_books#destroy", :id => "1")
    end

  end
end
