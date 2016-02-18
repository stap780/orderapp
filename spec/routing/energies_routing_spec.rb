require "rails_helper"

RSpec.describe EnergiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/energies").to route_to("energies#index")
    end

    it "routes to #new" do
      expect(:get => "/energies/new").to route_to("energies#new")
    end

    it "routes to #show" do
      expect(:get => "/energies/1").to route_to("energies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/energies/1/edit").to route_to("energies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/energies").to route_to("energies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/energies/1").to route_to("energies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/energies/1").to route_to("energies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/energies/1").to route_to("energies#destroy", :id => "1")
    end

  end
end
