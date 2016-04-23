require 'rails_helper'

RSpec.describe "Sskoms", type: :request do
  describe "GET /sskoms" do
    it "works! (now write some real specs)" do
      get sskoms_path
      expect(response).to have_http_status(200)
    end
  end
end
