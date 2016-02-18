require "rails_helper"

RSpec.describe MycouriersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mycouriers").to route_to("mycouriers#index")
    end

    it "routes to #new" do
      expect(:get => "/mycouriers/new").to route_to("mycouriers#new")
    end

    it "routes to #show" do
      expect(:get => "/mycouriers/1").to route_to("mycouriers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mycouriers/1/edit").to route_to("mycouriers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mycouriers").to route_to("mycouriers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/mycouriers/1").to route_to("mycouriers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/mycouriers/1").to route_to("mycouriers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mycouriers/1").to route_to("mycouriers#destroy", :id => "1")
    end

  end
end
