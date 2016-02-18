require 'rails_helper'

RSpec.describe "Angels", type: :request do
  describe "GET /angels" do
    it "works! (now write some real specs)" do
      get angels_path
      expect(response).to have_http_status(200)
    end
  end
end
