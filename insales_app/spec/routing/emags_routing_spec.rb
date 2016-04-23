require "rails_helper"

RSpec.describe EmagsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/emags").to route_to("emags#index")
    end

    it "routes to #new" do
      expect(:get => "/emags/new").to route_to("emags#new")
    end

    it "routes to #show" do
      expect(:get => "/emags/1").to route_to("emags#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/emags/1/edit").to route_to("emags#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/emags").to route_to("emags#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/emags/1").to route_to("emags#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/emags/1").to route_to("emags#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/emags/1").to route_to("emags#destroy", :id => "1")
    end

  end
end
