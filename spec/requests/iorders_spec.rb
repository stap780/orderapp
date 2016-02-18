require 'rails_helper'

RSpec.describe "Iorders", type: :request do
  describe "GET /iorders" do
    it "works! (now write some real specs)" do
      get iorders_path
      expect(response).to have_http_status(200)
    end
  end
end
