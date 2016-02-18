require 'rails_helper'

RSpec.describe "Energies", type: :request do
  describe "GET /energies" do
    it "works! (now write some real specs)" do
      get energies_path
      expect(response).to have_http_status(200)
    end
  end
end
