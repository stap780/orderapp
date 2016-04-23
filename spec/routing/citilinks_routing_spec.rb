require "rails_helper"

RSpec.describe CitilinksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/citilinks").to route_to("citilinks#index")
    end

    it "routes to #new" do
      expect(:get => "/citilinks/new").to route_to("citilinks#new")
    end

    it "routes to #show" do
      expect(:get => "/citilinks/1").to route_to("citilinks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/citilinks/1/edit").to route_to("citilinks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/citilinks").to route_to("citilinks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/citilinks/1").to route_to("citilinks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/citilinks/1").to route_to("citilinks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/citilinks/1").to route_to("citilinks#destroy", :id => "1")
    end

  end
end
