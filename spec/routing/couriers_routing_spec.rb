require "rails_helper"

RSpec.describe CouriersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/couriers").to route_to("couriers#index")
    end

    it "routes to #new" do
      expect(:get => "/couriers/new").to route_to("couriers#new")
    end

    it "routes to #show" do
      expect(:get => "/couriers/1").to route_to("couriers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/couriers/1/edit").to route_to("couriers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/couriers").to route_to("couriers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/couriers/1").to route_to("couriers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/couriers/1").to route_to("couriers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/couriers/1").to route_to("couriers#destroy", :id => "1")
    end

  end
end
