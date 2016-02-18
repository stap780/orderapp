require 'rails_helper'

RSpec.describe "Rrcs", type: :request do
  describe "GET /rrcs" do
    it "works! (now write some real specs)" do
      get rrcs_path
      expect(response).to have_http_status(200)
    end
  end
end
