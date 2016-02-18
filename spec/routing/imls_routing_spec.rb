require "rails_helper"

RSpec.describe ImlsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/imls").to route_to("imls#index")
    end

    it "routes to #new" do
      expect(:get => "/imls/new").to route_to("imls#new")
    end

    it "routes to #show" do
      expect(:get => "/imls/1").to route_to("imls#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/imls/1/edit").to route_to("imls#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/imls").to route_to("imls#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/imls/1").to route_to("imls#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/imls/1").to route_to("imls#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/imls/1").to route_to("imls#destroy", :id => "1")
    end

  end
end
