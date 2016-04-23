require 'rails_helper'

RSpec.describe "Treolans", type: :request do
  describe "GET /treolans" do
    it "works! (now write some real specs)" do
      get treolans_path
      expect(response).to have_http_status(200)
    end
  end
end
