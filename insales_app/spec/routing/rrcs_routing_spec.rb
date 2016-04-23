require "rails_helper"

RSpec.describe RrcsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rrcs").to route_to("rrcs#index")
    end

    it "routes to #new" do
      expect(:get => "/rrcs/new").to route_to("rrcs#new")
    end

    it "routes to #show" do
      expect(:get => "/rrcs/1").to route_to("rrcs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rrcs/1/edit").to route_to("rrcs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rrcs").to route_to("rrcs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rrcs/1").to route_to("rrcs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rrcs/1").to route_to("rrcs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rrcs/1").to route_to("rrcs#destroy", :id => "1")
    end

  end
end
