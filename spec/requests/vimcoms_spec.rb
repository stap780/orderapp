require 'rails_helper'

RSpec.describe "Vimcoms", type: :request do
  describe "GET /vimcoms" do
    it "works! (now write some real specs)" do
      get vimcoms_path
      expect(response).to have_http_status(200)
    end
  end
end
