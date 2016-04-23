require "rails_helper"

RSpec.describe HomyproductsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/homyproducts").to route_to("homyproducts#index")
    end

    it "routes to #new" do
      expect(:get => "/homyproducts/new").to route_to("homyproducts#new")
    end

    it "routes to #show" do
      expect(:get => "/homyproducts/1").to route_to("homyproducts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/homyproducts/1/edit").to route_to("homyproducts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/homyproducts").to route_to("homyproducts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/homyproducts/1").to route_to("homyproducts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/homyproducts/1").to route_to("homyproducts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/homyproducts/1").to route_to("homyproducts#destroy", :id => "1")
    end

  end
end
