require "rails_helper"

RSpec.describe AngelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/angels").to route_to("angels#index")
    end

    it "routes to #new" do
      expect(:get => "/angels/new").to route_to("angels#new")
    end

    it "routes to #show" do
      expect(:get => "/angels/1").to route_to("angels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/angels/1/edit").to route_to("angels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/angels").to route_to("angels#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/angels/1").to route_to("angels#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/angels/1").to route_to("angels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/angels/1").to route_to("angels#destroy", :id => "1")
    end

  end
end
