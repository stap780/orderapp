require "rails_helper"

RSpec.describe DpdsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/dpds").to route_to("dpds#index")
    end

    it "routes to #new" do
      expect(:get => "/dpds/new").to route_to("dpds#new")
    end

    it "routes to #show" do
      expect(:get => "/dpds/1").to route_to("dpds#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/dpds/1/edit").to route_to("dpds#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/dpds").to route_to("dpds#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dpds/1").to route_to("dpds#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dpds/1").to route_to("dpds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dpds/1").to route_to("dpds#destroy", :id => "1")
    end

  end
end
