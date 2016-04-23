# -*- encoding : utf-8 -*-
require "rails_helper"

RSpec.describe OrderstatusesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/orderstatuses").to route_to("orderstatuses#index")
    end

    it "routes to #new" do
      expect(:get => "/orderstatuses/new").to route_to("orderstatuses#new")
    end

    it "routes to #show" do
      expect(:get => "/orderstatuses/1").to route_to("orderstatuses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/orderstatuses/1/edit").to route_to("orderstatuses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/orderstatuses").to route_to("orderstatuses#create")
    end

    it "routes to #update" do
      expect(:put => "/orderstatuses/1").to route_to("orderstatuses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/orderstatuses/1").to route_to("orderstatuses#destroy", :id => "1")
    end

  end
end
