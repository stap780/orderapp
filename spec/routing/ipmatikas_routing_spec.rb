require "rails_helper"

RSpec.describe IpmatikasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ipmatikas").to route_to("ipmatikas#index")
    end

    it "routes to #new" do
      expect(:get => "/ipmatikas/new").to route_to("ipmatikas#new")
    end

    it "routes to #show" do
      expect(:get => "/ipmatikas/1").to route_to("ipmatikas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ipmatikas/1/edit").to route_to("ipmatikas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ipmatikas").to route_to("ipmatikas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ipmatikas/1").to route_to("ipmatikas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ipmatikas/1").to route_to("ipmatikas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ipmatikas/1").to route_to("ipmatikas#destroy", :id => "1")
    end

  end
end
