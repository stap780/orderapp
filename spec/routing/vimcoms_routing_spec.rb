require "rails_helper"

RSpec.describe VimcomsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/vimcoms").to route_to("vimcoms#index")
    end

    it "routes to #new" do
      expect(:get => "/vimcoms/new").to route_to("vimcoms#new")
    end

    it "routes to #show" do
      expect(:get => "/vimcoms/1").to route_to("vimcoms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/vimcoms/1/edit").to route_to("vimcoms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/vimcoms").to route_to("vimcoms#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/vimcoms/1").to route_to("vimcoms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/vimcoms/1").to route_to("vimcoms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/vimcoms/1").to route_to("vimcoms#destroy", :id => "1")
    end

  end
end
