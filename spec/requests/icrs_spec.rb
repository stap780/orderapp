require 'rails_helper'

RSpec.describe "Icrs", type: :request do
  describe "GET /icrs" do
    it "works! (now write some real specs)" do
      get icrs_path
      expect(response).to have_http_status(200)
    end
  end
end
