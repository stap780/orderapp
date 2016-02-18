require "rails_helper"

RSpec.describe IcrsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/icrs").to route_to("icrs#index")
    end

    it "routes to #new" do
      expect(:get => "/icrs/new").to route_to("icrs#new")
    end

    it "routes to #show" do
      expect(:get => "/icrs/1").to route_to("icrs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/icrs/1/edit").to route_to("icrs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/icrs").to route_to("icrs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/icrs/1").to route_to("icrs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/icrs/1").to route_to("icrs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/icrs/1").to route_to("icrs#destroy", :id => "1")
    end

  end
end
