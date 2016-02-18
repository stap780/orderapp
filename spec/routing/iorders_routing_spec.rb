require "rails_helper"

RSpec.describe IordersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/iorders").to route_to("iorders#index")
    end

    it "routes to #new" do
      expect(:get => "/iorders/new").to route_to("iorders#new")
    end

    it "routes to #show" do
      expect(:get => "/iorders/1").to route_to("iorders#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/iorders/1/edit").to route_to("iorders#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/iorders").to route_to("iorders#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/iorders/1").to route_to("iorders#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/iorders/1").to route_to("iorders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/iorders/1").to route_to("iorders#destroy", :id => "1")
    end

  end
end
