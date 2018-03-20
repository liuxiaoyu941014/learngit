require "rails_helper"

RSpec.describe Agent::MemberNotesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agent/member_notes").to route_to("agent/member_notes#index")
    end

    it "routes to #new" do
      expect(:get => "/agent/member_notes/new").to route_to("agent/member_notes#new")
    end

    it "routes to #show" do
      expect(:get => "/agent/member_notes/1").to route_to("agent/member_notes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agent/member_notes/1/edit").to route_to("agent/member_notes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agent/member_notes").to route_to("agent/member_notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agent/member_notes/1").to route_to("agent/member_notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agent/member_notes/1").to route_to("agent/member_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agent/member_notes/1").to route_to("agent/member_notes#destroy", :id => "1")
    end

  end
end
