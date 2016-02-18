require 'rails_helper'

RSpec.describe "Homyproducts", type: :request do
  describe "GET /homyproducts" do
    it "works! (now write some real specs)" do
      get homyproducts_path
      expect(response).to have_http_status(200)
    end
  end
end
