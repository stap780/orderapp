require "rails_helper"

RSpec.describe TreolansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/treolans").to route_to("treolans#index")
    end

    it "routes to #new" do
      expect(:get => "/treolans/new").to route_to("treolans#new")
    end

    it "routes to #show" do
      expect(:get => "/treolans/1").to route_to("treolans#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/treolans/1/edit").to route_to("treolans#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/treolans").to route_to("treolans#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/treolans/1").to route_to("treolans#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/treolans/1").to route_to("treolans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/treolans/1").to route_to("treolans#destroy", :id => "1")
    end

  end
end
