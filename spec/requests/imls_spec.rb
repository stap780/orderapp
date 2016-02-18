require 'rails_helper'

RSpec.describe "Imls", type: :request do
  describe "GET /imls" do
    it "works! (now write some real specs)" do
      get imls_path
      expect(response).to have_http_status(200)
    end
  end
end
