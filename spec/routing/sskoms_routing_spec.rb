require "rails_helper"

RSpec.describe SskomsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sskoms").to route_to("sskoms#index")
    end

    it "routes to #new" do
      expect(:get => "/sskoms/new").to route_to("sskoms#new")
    end

    it "routes to #show" do
      expect(:get => "/sskoms/1").to route_to("sskoms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sskoms/1/edit").to route_to("sskoms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sskoms").to route_to("sskoms#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sskoms/1").to route_to("sskoms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sskoms/1").to route_to("sskoms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sskoms/1").to route_to("sskoms#destroy", :id => "1")
    end

  end
end
